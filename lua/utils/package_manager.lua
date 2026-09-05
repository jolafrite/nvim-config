---@class PackageManager.Spec
---@field [1] string plugin repo url
---@field dependencies? string[] dependencies to load along with the plugin
---@field event? string|string[] event(s) to trigger loading
---@field filetype? string|string[] filetypes to trigger loading
---@field config? fun() config function
---@field loaded? boolean is plugin loaded

---@class PackageManager
---@field add fun(spec: PackageManager.Spec)
---@field add_with_mason fun(tools: string|string[])
---@field add_formatter fun(ft: string|string[], formatters: string|string[], on_conform?: fun(conform: table))
---@field add_linter fun(ft: string|string[], linters: string|string[], on_lint?: fun(lint: table))
---@field add_debugger fun(ft: string|string[], debuggers: string|string[])
---@field add_snippets fun(ft: string|string[], snippets? string|string[])
---@field add_tester fun(ft: string|string[], adapters: table, on_test?: fun(test: table))
---@field add_with_treesitter fun(tools: string|string[])
---@field load fun()
local M = {}

-- Neovim 0.13: vim.async provides structured concurrency for the
-- async install pipeline (mason refresh + install, treesitter install).
local async = vim.async or function(fn) return fn() end

-- Neovim 0.13: vim.log provides a structured logging interface.
-- Use it for consistent log levels and output.
local log = vim.log or {
  warn = function(msg) vim.notify(msg, vim.log.levels.WARN) end,
  info = function(msg) vim.notify(msg, vim.log.levels.INFO) end,
  error = function(msg) vim.notify(msg, vim.log.levels.ERROR) end,
}

---@type PackageManager.Spec[]
local registry = {}

---@type string[]
local mason_tools = {}
---
---@type string[]
local pending_treesitter = {}

---@type { ft: string[], tools: string[] }[]
local pending_formatters = {}

---@type { ft: string[], tools: string[] }[]
local pending_linters = {}

---@type { ft: string[], tools: string[] }[]
local pending_debuggers = {}

---@type { ft: string[], tools: string[] }[]
local pending_snippets = {}

---@type { ft: string[], adapters: table }[]
local pending_testers = {}

---@type table<string, string[]>
local debugger_fts = {}

---@type string[]
local snippet_fts = {}
local snippets_registered = false

---Accumulated neotest adapters. neotest.setup replaces its whole config, so
---we keep every registered adapter ourselves and always setup with the full
---list.
---@type table[]
local tester_adapters = {}

local activated = false

---@param s PackageManager.Spec
local function load_spec(s)
  if s.loaded then return end
  s.loaded = true

  ---@type string[]
  local to_add = {}
  for _, dep in ipairs(s.dependencies or {}) do
    to_add[#to_add + 1] = dep
  end
  to_add[#to_add + 1] = s[1]

  local ok, err = pcall(vim.pack.add, to_add, { load = true, confirm = false })
  if not ok then log.warn('package_manager: failed to load ' .. tostring(s[1]) .. ': ' .. tostring(err)) end
  if s.config then
    local ok_cfg, cfg_err = pcall(s.config)
    if not ok_cfg then log.warn('package_manager: config failed for ' .. tostring(s[1]) .. ': ' .. tostring(cfg_err)) end
  end
end

---@param tools string[]
local function install_with_mason(tools)
  local ok, mr = pcall(require, 'mason-registry')
  if not ok then return false end

  ---@type fun(cb: fun())
  local function do_install(cb)
    local seen = {}
    for _, tool in ipairs(tools) do
      if not seen[tool] then
        seen[tool] = true
        local ok_p, p = pcall(mr.get_package, tool)
        if not ok_p then
          log.warn(('mason: unknown package %q'):format(tool))
        elseif not p:is_installed() then
          local ok_i, err = pcall(p.install, p)
          if not ok_i then log.warn(('mason: failed to install %q: %s'):format(tool, tostring(err))) end
        end
      end
    end
    cb()
  end

  -- Refresh the registry first to avoid races with Mason's async setup.
  -- `is_installed` checks whether a single package is on disk, so it cannot be
  -- used to probe registry readiness; calling it as `mr:is_installed()` passes
  -- the registry table itself as the package name and crashes table.concat.
  -- Neovim 0.13: use vim.async for structured concurrency around the refresh.
  local ok_p, _ = pcall(mr.get_package, 'lua')
  if ok_p then
    do_install(function() end)
  else
    async(function()
      mr.refresh(function() do_install(function() end) end)
    end)
  end
  return true
end

---@param filetypes string[]
---@param tools string[]
---@param on_conform? fun(conform: table)
local function setup_formatters(filetypes, tools, on_conform)
  local ok, conform = pcall(require, 'conform')
  if not ok then return false end
  for _, f in ipairs(filetypes) do
    local existing = conform.formatters_by_ft[f]
    local merged = {}
    vim.list_extend(merged, type(existing) == 'table' and existing or { existing })
    vim.list_extend(merged, tools)
    conform.formatters_by_ft[f] = merged
  end
  if on_conform then on_conform(conform) end
  return true
end

---@param filetypes string[]
---@param tools string[]
---@param on_lint? fun(lint: table)
local function setup_linters(filetypes, tools, on_lint)
  local ok, lint = pcall(require, 'lint')
  if not ok then return false end
  for _, f in ipairs(filetypes) do
    local existing = lint.linters_by_ft[f]
    local merged = {}
    vim.list_extend(merged, type(existing) == 'table' and existing or { existing })
    vim.list_extend(merged, tools)
    lint.linters_by_ft[f] = merged
  end
  if on_lint then on_lint(lint) end
  return true
end

---@param filetypes string[]
---@param tools string[] mason package names of the debug adapters
local function setup_debuggers(filetypes, tools)
  local ok, dap = pcall(require, 'dap')
  if not ok then return false end
  for _, f in ipairs(filetypes) do
    debugger_fts[f] = debugger_fts[f] or {}
    vim.list_extend(debugger_fts[f], tools)
  end
  for _, f in ipairs(filetypes) do
    dap.configurations[f] = dap.configurations[f] or {}
  end
  return true
end

---@param tools string[]
local function setup_treesitter(tools)
  local ok, ts = pcall(require, 'nvim-treesitter')
  if not ok then return false end
  pcall(ts.install, tools)
  return true
end

---@param pending { ft: string[], adapters: table }[]
local function setup_testers(pending)
  local ok, neotest = pcall(require, 'neotest')
  if not ok then return false end
  for _, t in ipairs(pending) do
    -- Accept the LazyVim-style keyed form { ['neotest-golang'] = { opts } }
    -- as well as a plain list of adapter modules. neotest itself only
    -- iterates adapters with ipairs, so keyed tables must be resolved here.
    for name, opts in pairs(t.adapters) do
      if type(name) == 'string' and type(opts) == 'table' then
        local ok_mod, mod = pcall(require, name)
        if not ok_mod then
          log.warn(('neotest: adapter %q is not installed'):format(name))
        else
          tester_adapters[#tester_adapters + 1] = type(mod) == 'function' and mod(opts) or mod
        end
      else
        tester_adapters[#tester_adapters + 1] = opts
      end
    end
    if t.on_test then t.on_test(neotest) end
  end
  -- neotest.setup replaces its config entirely, so always pass every adapter
  -- registered so far.
  pcall(neotest.setup, { adapters = tester_adapters })
  return true
end

---@param pending { ft: string[], tools: string[] }[]
local function setup_snippets(pending)
  if snippets_registered then return true end
  snippets_registered = true
  for _, s in ipairs(pending) do
    vim.list_extend(snippet_fts, s.ft)
  end
  return true
end

-- ─── scheduling + drain ──────────────────────────────────────────────────────

---@param spec PackageManager.Spec
local function schedule_spec(spec)
  if spec.event then
    local events = type(spec.event) == 'string' and { spec.event } or spec.event
    if vim.list_contains(events, 'FileType') then
      local loaded_now = false
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= '' then
          load_spec(spec)
          loaded_now = true
          break
        end
      end
      if not loaded_now then vim.api.nvim_create_autocmd(events, {
        once = true,
        callback = function() load_spec(spec) end,
      }) end
    else
      vim.api.nvim_create_autocmd(events, {
        once = true,
        callback = function() load_spec(spec) end,
      })
    end
  elseif spec.filetype then
    local fts = type(spec.filetype) == 'string' and { spec.filetype } or spec.filetype
    local loaded_now = false
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.list_contains(fts, vim.bo[buf].filetype) then
        load_spec(spec)
        loaded_now = true
        break
      end
    end
    if not loaded_now then
      vim.api.nvim_create_autocmd('FileType', {
        pattern = fts,
        once = true,
        callback = function()
          load_spec(spec)
          -- Reproduce require('utils').on_file_types behaviour: source the
          -- filetype's ftplugin after the spec's config has run, so ftplugin
          -- overrides (e.g. buffer-local keymaps) take effect.
          vim.cmd('runtime! ftplugin/' .. vim.bo.filetype .. '.lua')
          vim.cmd('runtime! ftplugin/' .. vim.bo.filetype .. '.vim')
          return true
        end,
      })
    end
  else
    load_spec(spec)
  end
end

local function drain_pendings()
  for i = #pending_formatters, 1, -1 do
    if setup_formatters(pending_formatters[i].ft, pending_formatters[i].tools, pending_formatters[i].on_conform) then table.remove(pending_formatters, i) end
  end

  for i = #pending_linters, 1, -1 do
    if setup_linters(pending_linters[i].ft, pending_linters[i].tools, pending_linters[i].on_lint) then table.remove(pending_linters, i) end
  end

  for i = #pending_debuggers, 1, -1 do
    if setup_debuggers(pending_debuggers[i].ft, pending_debuggers[i].tools) then table.remove(pending_debuggers, i) end
  end

  if #pending_testers > 0 and setup_testers(pending_testers) then pending_testers = {} end

  if #pending_snippets > 0 and setup_snippets(pending_snippets) then pending_snippets = {} end
end

local function load_dependencies()
  for _, spec in ipairs(registry) do
    schedule_spec(spec)
  end
  registry = {}

  -- Neovim 0.13: run mason install + treesitter setup in an async context
  -- so they don't block the startup sequence.
  async(function()
    install_with_mason(mason_tools)
    mason_tools = {}

    setup_treesitter(pending_treesitter)
    pending_treesitter = {}

    drain_pendings()
  end)
end

-- ─── public API ─────────────────────────────────────────────────────────────

---@param spec PackageManager.Spec
M.add = function(spec)
  registry[#registry + 1] = spec
  if activated then load_dependencies() end
end

---@param tools string|string[]
M.add_with_mason = function(tools)
  local list = type(tools) == 'string' and { tools } or tools
  vim.list_extend(mason_tools, list)
  if activated then load_dependencies() end
end

---@param tools string|string[]
M.add_with_treesitter = function(tools)
  local list = type(tools) == 'string' and { tools } or tools
  vim.list_extend(pending_treesitter, list)
  if activated then load_dependencies() end
end

---@param ft string|string[]
---@param formatters string|string[]
---@param on_conform? fun(conform: table) optional callback receiving the
---conform module, for custom formatter definitions / global opts
M.add_formatter = function(ft, formatters, on_conform)
  pending_formatters[#pending_formatters + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    tools = type(formatters) == 'string' and { formatters } or formatters,
    on_conform = on_conform,
  }
  if activated then load_dependencies() end
end

---@param ft string|string[]
---@param linters string|string[]
---@param on_lint? fun(lint: table) optional callback receiving the
---lint module, for custom linter definitions
M.add_linter = function(ft, linters, on_lint)
  pending_linters[#pending_linters + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    tools = type(linters) == 'string' and { linters } or linters,
    on_lint = on_lint,
  }
  if activated then load_dependencies() end
end

---@param ft string|string[]
---@param debuggers string|string[] mason package names of the debug adapters
M.add_debugger = function(ft, debuggers)
  pending_debuggers[#pending_debuggers + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    tools = type(debuggers) == 'string' and { debuggers } or debuggers,
  }
  if activated then load_dependencies() end
end

---@param ft string|string[]
---@param snippets? string|string[]
M.add_snippets = function(ft, snippets)
  pending_snippets[#pending_snippets + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    tools = type(snippets) == 'string' and { snippets } or snippets or {},
  }
  if activated then load_dependencies() end
end

---@param ft string|string[]
---@param adapters table neotest adapters, either the LazyVim-style keyed form
---({ ['neotest-golang'] = { opts } }) or a plain list of adapter modules
---@param on_test? fun(neotest: table) optional callback receiving the
---neotest module, for custom setup (keymaps, consumers, ...)
M.add_tester = function(ft, adapters, on_test)
  pending_testers[#pending_testers + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    adapters = adapters,
    on_test = on_test,
  }
  if activated then load_dependencies() end
end

M.load = function()
  load_dependencies()
  activated = true
end

_G.PackageManager = M
return M
