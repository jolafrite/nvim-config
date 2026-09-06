local M = {}

local function module_name(file)
  local lua_root = vim.fn.stdpath 'config' .. '/lua/'
  local mod = file:sub(#lua_root + 1, -5):gsub('/', '.')
  return (mod:gsub('%.%d+%-?', '.'))
end

local function load_file(file)
  if vim.fn.fnamemodify(file, ':t') == 'init.lua' then return end
  local mod = module_name(file)
  if package.loaded[mod] then return end
  local chunk, err = loadfile(file)
  if not chunk then error('loadfile ' .. file .. ': ' .. tostring(err)) end
  local ok, run_err = pcall(chunk)
  if not ok then
    vim.schedule(function() vim.notify(('plugins_loader: %s:\n%s'):format(file, run_err), vim.log.levels.ERROR) end)
    return
  end
  package.loaded[mod] = true
end

---@param path string Directory relative to lua/, e.g. "plugins".
function M.load(path)
  local dir = vim.fn.stdpath 'config' .. '/lua/' .. path
  local pattern = dir .. '/**/*.lua'

  for _, file in ipairs(vim.fn.glob(pattern, true, true)) do
    load_file(file)
  end
end

_G.PluginsLoader = M
return M
