-- Plugin loader.
--
-- Each plugin file in lua/plugins/*.lua registers a spec via Manager.add().
-- This file first loads every plugin file (so their Manager.add() calls
-- populate H.plugin_specs), then calls Manager.load_all() which does the
-- actual startup/event/filetype split loading.
--
-- pack.lua and pack_float.lua are NOT plugin specs — they are the vim.pack
-- update engine and its float UI. They are loaded explicitly in the top-level
-- init chain and skipped here.

local plugin_path = vim.fn.stdpath 'config' .. '/lua/plugins'
for _, file in ipairs(vim.fn.glob(plugin_path .. '/*.lua', true, true)) do
  local name = vim.fn.fnamemodify(file, ':t:r')
  if name ~= 'init' and name ~= 'pack' and name ~= 'pack_float' then
    local req_name = name:match '^%d+%-?(.*)$' or name
    if not package.loaded['plugins.' .. req_name] then
      local fn, err = loadfile(file)
      if not fn then error('loadfile ' .. file .. ': ' .. tostring(err)) end
      fn()
      package.loaded['plugins.' .. req_name] = true
    end
  end
end

return Manager.load_all()

-- vim: ts=2 sts=2 sw=2 et
