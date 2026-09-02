--- Recursively loads Lua files from a directory under the config's lua/ dir.
---
--- Every *.lua file is executed exactly once, except init.lua files (entry
--- points) and anything already in package.loaded. Module names are derived
--- from the path relative to lua/ (e.g. "plugins/00-snacks.lua" loads as
--- "plugins.snacks"), so require() and package.loaded keep working for any
--- file the loader has seen.
---
--- Intended as two passes around PackageManager.load_all(): a flat pass first
--- (spec files and startup config), then a recursive pass for nested config
--- files (e.g. plugins/lang/*) that require startup-loaded plugins such as
--- conform, lint or nvim-treesitter. Specs registered in either pass are
--- handled by PackageManager at any time.

local M = {}

local function module_name(file)
  local lua_root = vim.fn.stdpath 'config' .. '/lua/'
  local mod = file:sub(#lua_root + 1, -5):gsub('/', '.')
  -- Strip a numeric sort prefix from the last segment ("00-snacks" -> "snacks").
  return (mod:gsub('%.%d+%-?', '.'))
end

---@param path string Directory relative to lua/, e.g. "plugins".
---@param opts? { recursive?: boolean } Also search subdirectories.
function M.load(path, opts)
  opts = opts or {}
  local dir = vim.fn.stdpath 'config' .. '/lua/' .. path
  local pattern = dir .. (opts.recursive and '/**/*.lua' or '/*.lua')

  for _, file in ipairs(vim.fn.glob(pattern, true, true)) do
    if vim.fn.fnamemodify(file, ':t') ~= 'init.lua' then
      local mod = module_name(file)
      if not package.loaded[mod] then
        local chunk, err = loadfile(file)
        if not chunk then error('loadfile ' .. file .. ': ' .. tostring(err)) end
        local ok, run_err = pcall(chunk)
        if ok then
          package.loaded[mod] = true
        else
          -- One broken file must not abort the pass: report it and go on,
          -- so the remaining configs still load.
          vim.schedule(function()
            vim.notify(('plugins_loader: %s:\n%s'):format(file, run_err), vim.log.levels.ERROR)
          end)
        end
      end
    end
  end
end

return M
