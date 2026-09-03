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
---@field add_formatter fun(ft: string|string[], formatters: string|string[])
---@field add_linter fun(ft: string|string[], linters: string|string[])
---@field add_debugger fun(ft: string|string[], debuggers: string|string[])
---@field add_snippets fun(ft: string|string[], snippets: string|string[])
---@field load fun()
local M = {}

---@type PackageManager.Spec[]
local registry = {}

---@type string[]
local mason_tools = {}

---@type { ft: string[], tools: string[] }[]
local pending_formatters = {}

---@type { ft: string[], tools: string[] }[]
local pending_linters = {}

---@type { ft: string[], tools: string[] }[]
local pending_debuggers = {}

---@type { ft: string[], tools: string[] }[]
local pending_snippets = {}

local activated = false

-- ─── helpers ────────────────────────────────────────────────────────────────

---@param s PackageManager.Spec
local function load_spec(s)
  if s.loaded then
    return
  end
  s.loaded = true

  ---@type string[]
  local to_add = {}
  for _, dep in ipairs(s.dependencies or {}) do
    to_add[#to_add + 1] = dep
  end
  to_add[#to_add + 1] = s[1]

  local ok, err = pcall(vim.pack.add, to_add, { load = true, confirm = false })
  if not ok then
    vim.notify(
      "package_manager: failed to load "
        .. tostring(s[1])
        .. ": "
        .. tostring(err),
      vim.log.levels.WARN
    )
  end
  if s.config then
    pcall(s.config)
  end
end

---@param tools string[]
local function install_with_mason(tools)
  local ok, mr = pcall(require, "mason-registry")
  if not ok then
    return false
  end
  for _, tool in ipairs(tools) do
    local ok_p, p = pcall(mr.get_package, tool)
    if not ok_p then
      vim.notify(
        ("mason: unknown package %q"):format(tool),
        vim.log.levels.WARN
      )
    elseif not p:is_installed() then
      p:install()
    end
  end
  return true
end

---@param filetypes string[]
---@param tools string[]
local function setup_formatters(filetypes, tools)
  local ok, conform = pcall(require, "conform")
  if not ok then
    return false
  end
  for _, f in ipairs(filetypes) do
    conform.formatters_by_ft[f] = tools
  end
  return true
end

---@param filetypes string[]
---@param tools string[]
local function setup_linters(filetypes, tools)
  local ok, lint = pcall(require, "lint")
  if not ok then
    return false
  end
  for _, f in ipairs(filetypes) do
    lint.linters_by_ft[f] = tools
  end
  return true
end

---@param filetypes string[]
---@param tools string[]
local function setup_debuggers(filetypes, tools)
  local ok, dap = pcall(require, "dap")
  if not ok then
    return false
  end
  for _, f in ipairs(filetypes) do
    dap.configurations[f] = dap.configurations[f] or {}
    vim.list_extend(dap.configurations[f], tools)
  end
  return true
end

-- ─── core: drain everything ─────────────────────────────────────────────────

local function load_dependencies()
  for _, spec in ipairs(registry) do
    if spec.event then
      local events = type(spec.event) == "string" and { spec.event }
        or spec.event
      if vim.list_contains(events, "FileType") then
        local loaded_now = false
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
            load_spec(spec)
            loaded_now = true
            break
          end
        end
        if not loaded_now then
          vim.api.nvim_create_autocmd(events, {
            once = true,
            callback = function()
              load_spec(spec)
            end,
          })
        end
      else
        vim.api.nvim_create_autocmd(events, {
          once = true,
          callback = function()
            load_spec(spec)
          end,
        })
      end
    elseif spec.filetype then
      local fts = type(spec.filetype) == "string" and { spec.filetype }
        or spec.filetype
      local loaded_now = false
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if
          vim.api.nvim_buf_is_loaded(buf)
          and vim.list_contains(fts, vim.bo[buf].filetype)
        then
          load_spec(spec)
          loaded_now = true
          break
        end
      end
      if not loaded_now then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = fts,
          once = true,
          callback = function()
            load_spec(spec)
            -- Reproduce require('utils').on_file_types behaviour: source the
            -- filetype's ftplugin after the spec's config has run, so ftplugin
            -- overrides (e.g. buffer-local keymaps) take effect.
            vim.cmd("runtime! ftplugin/" .. vim.bo.filetype .. ".lua")
            vim.cmd("runtime! ftplugin/" .. vim.bo.filetype .. ".vim")
            return true
          end,
        })
      end
    else
      load_spec(spec)
    end
  end
  registry = {}

  if #mason_tools > 0 then
    if not install_with_mason(mason_tools) then
      return
    end
    mason_tools = {}
  end

  for i = #pending_formatters, 1, -1 do
    if
      setup_formatters(pending_formatters[i].ft, pending_formatters[i].tools)
    then
      table.remove(pending_formatters, i)
    end
  end

  for i = #pending_linters, 1, -1 do
    if setup_linters(pending_linters[i].ft, pending_linters[i].tools) then
      table.remove(pending_linters, i)
    end
  end

  for i = #pending_debuggers, 1, -1 do
    if setup_debuggers(pending_debuggers[i].ft, pending_debuggers[i].tools) then
      table.remove(pending_debuggers, i)
    end
  end

  for i = #pending_snippets, 1, -1 do
    table.remove(pending_snippets, i)
  end
end

-- ─── public API ─────────────────────────────────────────────────────────────

---@param spec PackageManager.Spec
M.add = function(spec)
  registry[#registry + 1] = spec
  if activated then
    load_dependencies()
  end
end

---@param tools string|string[]
M.add_with_mason = function(tools)
  local list = type(tools) == "string" and { tools } or tools
  vim.list_extend(mason_tools, list)
  if activated then
    load_dependencies()
  end
end

---@param tools string|string[]
M.add_with_treesitter = function(tools)
  local list = type(tools) == "string" and { tools } or tools
  local ok, ts = pcall(require, "nvim-treesitter")
  if not ok then
    return
  end
  pcall(ts.install, list)
end

---@param ft string|string[]
---@param formatters string|string[]
M.add_formatter = function(ft, formatters)
  pending_formatters[#pending_formatters + 1] = {
    ft = type(ft) == "string" and { ft } or ft,
    tools = type(formatters) == "string" and { formatters } or formatters,
  }
  if activated then
    load_dependencies()
  end
end

---@param ft string|string[]
---@param linters string|string[]
M.add_linter = function(ft, linters)
  pending_linters[#pending_linters + 1] = {
    ft = type(ft) == "string" and { ft } or ft,
    tools = type(linters) == "string" and { linters } or linters,
  }
  if activated then
    load_dependencies()
  end
end

---@param ft string|string[]
---@param debuggers string|string[]
M.add_debugger = function(ft, debuggers)
  pending_debuggers[#pending_debuggers + 1] = {
    ft = type(ft) == "string" and { ft } or ft,
    tools = type(debuggers) == "string" and { debuggers } or debuggers,
  }
  if activated then
    load_dependencies()
  end
end

---@param ft string|string[]
---@param snippets string|string[]
M.add_snippets = function(ft, snippets)
  pending_snippets[#pending_snippets + 1] = {
    ft = type(ft) == "string" and { ft } or ft,
    tools = type(snippets) == "string" and { snippets } or snippets,
  }
  if activated then
    load_dependencies()
  end
end

M.load = function()
  load_dependencies()
  activated = true
end

_G.PackageManager = M
return M
