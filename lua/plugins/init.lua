-- Plugin loader.
--
-- Each plugin file in lua/plugins/*.lua registers a spec via PackageManager.add().
-- PackageManager.load_all() does the actual startup/event/filetype split loading.
--
-- Language plugin files live in lua/plugins/lang/ and are loaded by
-- lua/plugins/lang/init.lua (two-phase: specs first, then config-only files
-- after conform/lint/treesitter are loaded).
--
-- The vim.pack update engine and float UI live in lua/utils/package_manager/
-- and are pulled in by require('utils.package_manager') — they are not plugin
-- files here and are not loaded by this loop.

local plugin_path = vim.fn.stdpath("config") .. "/lua/plugins"

-- Load every plugin file (registers its PackageManager.add() spec).
for _, file in ipairs(vim.fn.glob(plugin_path .. "/*.lua", true, true)) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  if name ~= "init" then
    local req_name = name:match("^%d+%-?(.*)$") or name
    if not package.loaded["plugins." .. req_name] then
      local fn, err = loadfile(file)
      if not fn then
        error("loadfile " .. file .. ": " .. tostring(err))
      end
      fn()
      package.loaded["plugins." .. req_name] = true
    end
  end
end

return PackageManager.load_all()

-- vim: ts=2 sts=2 sw=2 et
