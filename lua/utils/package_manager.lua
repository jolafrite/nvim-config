

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
---@field add_debugger fun(ft: string|string[], debuggers: string|string[], on_dap?: fun(dap: table))
---@field add_snippets fun(ft: string|string[], snippets? string|string[])
---@field add_tester fun(ft: string|string[], adapters: table, on_test?: fun(test: table))
---@field add_with_treesitter fun(tools: string|string[])
---@field load fun()
local M = {}

---@type PackageManager.Spec[]
local registry = {}

---@type string[]
local mason_tools = {}

local pending_treesitter = {}

local pending_formatters = {}

local pending_linters = {}

local pending_debuggers = {}

local pending_snippets = {}

local pending_testers = {}

local snippets_registered = false

local tester_adapters = {}

local _levels = (vim.log and vim.log.levels) or { warn = 2, info = 1, error = 0 }

local async = vim.async and vim.async.run or function(fn) return fn() end

local activated = false

local function load_spec(s)
  if s.loaded then return end
  s.loaded = true

  local to_add = {}
  for _, dep in ipairs(s.dependencies or {}) do
    to_add[#to_add + 1] = dep
  end
  to_add[#to_add + 1] = s[1]

  local ok, err = pcall(vim.pack.add, to_add, { load = true, confirm = false })
  if not ok then vim.notify('package_manager: failed to load ' .. tostring(s[1]) .. ': ' .. tostring(err), _levels.warn) end
  if s.config then
    local ok_cfg, cfg_err = pcall(s.config)
    if not ok_cfg then vim.notify('package_manager: config failed for ' .. tostring(s[1]) .. ': ' .. tostring(cfg_err), _levels.warn) end
  end
end

local function install_with_mason(tools)
  local ok, mr = pcall(require, 'mason-registry')
  if not ok then return false end

  local function do_install(cb)
    local seen = {}
    for _, tool in ipairs(tools) do
      if not seen[tool] then
        seen[tool] = true
        local ok_p, p = pcall(mr.get_package, tool)
        if not ok_p then
          vim.notify(('mason: unknown package %q'):format(tool), _levels.warn)
        elseif not p:is_installed() then
          local ok_i, err = pcall(p.install, p)
          if not ok_i then vim.notify(('mason: failed to install %q: %s'):format(tool, tostring(err)), _levels.warn) end
        end
      end
    end
    cb()
  end

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
  if on_conform then
    local ok_cb, cb_err = pcall(on_conform, conform)
    if not ok_cb then vim.notify('package_manager: conform setup failed for ' .. table.concat(filetypes, ', ') .. ': ' .. tostring(cb_err), _levels.warn) end
  end
  return true
end

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
  if on_lint then
    local ok_cb, cb_err = pcall(on_lint, lint)
    if not ok_cb then vim.notify('package_manager: lint setup failed for ' .. table.concat(filetypes, ', ') .. ': ' .. tostring(cb_err), _levels.warn) end
  end
  return true
end

local function setup_debuggers(filetypes, tools, on_dap)
  local ok, dap = pcall(require, 'dap')
  if not ok then return false end
  for _, f in ipairs(filetypes) do
    dap.configurations[f] = dap.configurations[f] or {}
  end
  if on_dap then
    local ok_dap, dap_err = pcall(on_dap, dap)
    if not ok_dap then vim.notify('package_manager: dap setup failed for ' .. table.concat(filetypes, ', ') .. ': ' .. tostring(dap_err), _levels.warn) end
  end
  return true
end

local function setup_treesitter(tools)
  local ok, ts = pcall(require, 'nvim-treesitter')
  if not ok then return false end
  pcall(ts.install, tools)
  return true
end

local function setup_testers(pending)
  local ok, neotest = pcall(require, 'neotest')
  if not ok then return false end
  for _, t in ipairs(pending) do

    for name, opts in pairs(t.adapters) do
      if type(name) == 'string' and type(opts) == 'table' then
        local ok_mod, mod = pcall(require, name)
        if not ok_mod then
          vim.notify(('neotest: adapter %q is not installed'):format(name), _levels.warn)
        else
          tester_adapters[#tester_adapters + 1] = type(mod) == 'function' and mod(opts) or mod
        end
      else
        tester_adapters[#tester_adapters + 1] = opts
      end
    end
    if t.on_test then t.on_test(neotest) end
  end

  pcall(neotest.setup, { adapters = tester_adapters })
  return true
end

local function setup_snippets(pending)
  if snippets_registered then return true end
  snippets_registered = true
  return true
end

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
    if setup_debuggers(pending_debuggers[i].ft, pending_debuggers[i].tools, pending_debuggers[i].on_dap) then table.remove(pending_debuggers, i) end
  end

  if #pending_testers > 0 and setup_testers(pending_testers) then pending_testers = {} end

  if #pending_snippets > 0 and setup_snippets(pending_snippets) then pending_snippets = {} end
end

local function load_dependencies()
  for _, spec in ipairs(registry) do
    schedule_spec(spec)
  end
  registry = {}

  install_with_mason(mason_tools)
  mason_tools = {}

  setup_treesitter(pending_treesitter)
  pending_treesitter = {}

  drain_pendings()
end

M.add = function(spec)
  registry[#registry + 1] = spec
  if activated then load_dependencies() end
end

M.add_with_mason = function(tools)
  local list = type(tools) == 'string' and { tools } or tools
  vim.list_extend(mason_tools, list)
  if activated then load_dependencies() end
end

M.add_with_treesitter = function(tools)
  local list = type(tools) == 'string' and { tools } or tools
  vim.list_extend(pending_treesitter, list)
  if activated then load_dependencies() end
end

M.add_formatter = function(ft, formatters, on_conform)
  pending_formatters[#pending_formatters + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    tools = type(formatters) == 'string' and { formatters } or formatters,
    on_conform = on_conform,
  }
  if activated then load_dependencies() end
end

M.add_linter = function(ft, linters, on_lint)
  pending_linters[#pending_linters + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    tools = type(linters) == 'string' and { linters } or linters,
    on_lint = on_lint,
  }
  if activated then load_dependencies() end
end

M.add_debugger = function(ft, debuggers, on_dap)
  pending_debuggers[#pending_debuggers + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    tools = type(debuggers) == 'string' and { debuggers } or debuggers,
    on_dap = on_dap,
  }
  if activated then load_dependencies() end
end

M.add_snippets = function(ft, snippets)
  pending_snippets[#pending_snippets + 1] = {
    ft = type(ft) == 'string' and { ft } or ft,
    tools = type(snippets) == 'string' and { snippets } or snippets or {},
  }
  if activated then load_dependencies() end
end

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
