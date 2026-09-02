local plugin_path = vim.fn.stdpath 'config' .. '/lua/plugins'

for _, file in ipairs(vim.fn.glob(plugin_path .. '/*.lua', true, true)) do
  local name = vim.fn.fnamemodify(file, ':t:r')
  if name ~= 'init' then
    local req_name = name:match '^%d+%-?(.*)$' or name
    if not package.loaded['plugins.' .. req_name] then
      local fn, err = loadfile(file)
      if not fn then error('loadfile ' .. file .. ': ' .. tostring(err)) end
      fn()
      package.loaded['plugins.' .. req_name] = true
    end
  end
end

PackageManager.load_all()

-- Language configs are loaded after the plugins themselves: spec files
-- register their filetype/event triggers with PackageManager (which handles
-- post-load_all registration), config files set up conform/lint/treesitter
-- and LSP for the startup-loaded plugins.
require 'plugins.lang'

-- vim: ts=2 sts=2 sw=2 et
