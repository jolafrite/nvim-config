local plugin_path = vim.fn.stdpath 'config' .. '/lua/plugins/lang'
local plugins = vim.fn.glob(plugin_path .. '/*.lua', true, true)
for _, file in ipairs(plugins) do
  local name = vim.fn.fnamemodify(file, ':t:r')
  if name ~= 'init' then
    local req_name = name:match '^%d+%-?(.*)$' or name
    if package.loaded['plugins.lang.' .. req_name] then goto continue end
    local fn, err = loadfile(file)
    if not fn then error('loadfile ' .. file .. ': ' .. tostring(err)) end
    fn()
    package.loaded['plugins.lang.' .. req_name] = true
    ::continue::
  end
end
-- vim: ts=2 sts=2 sw=2 et
