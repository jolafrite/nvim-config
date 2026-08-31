local plugin_path = vim.fn.stdpath 'config' .. '/lua/plugins'
local plugins = vim.fn.glob(plugin_path .. '/*.lua', true, true)
for _, file in ipairs(plugins) do
  local name = vim.fn.fnamemodify(file, ':t:r')
  if name ~= 'init' then
    local req_name = name:match '^%d+%-?(.*)$' or name
    if not package.loaded['plugins.' .. req_name] then
      local fn, err = loadfile(file)
      if not fn then error('loadfile ' .. file .. ': ' .. tostring(err)) end
      -- Store a returned module table so require() resolves to it (e.g. plugins.pack_float).
      local result = fn()
      package.loaded['plugins.' .. req_name] = result ~= nil and result or true
    end
  end
end
-- vim: ts=2 sts=2 sw=2 et
