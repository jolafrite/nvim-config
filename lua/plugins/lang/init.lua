-- Language plugin loader.
--
-- Every file in lua/plugins/lang/*.lua registers a spec via PackageManager.add()
-- — either a plugin spec (e.g. go.lua) or a config-only spec (LSP/conform/lint/
-- treesitter wiring with no external plugin package) — with a filetype trigger,
-- so language configs only load when a buffer of that filetype is opened, not
-- at Neovim startup.
--
-- Must run before PackageManager.load_all() (i.e. before require 'plugins'),
-- so the filetype triggers are wired when load_all() splits the specs.

local lang_path = vim.fn.stdpath 'config' .. '/lua/plugins/lang'

local M = {}

--- Load every lang spec file (registers its PackageManager.add() spec).
function M.load_specs()
  for _, file in ipairs(vim.fn.glob(lang_path .. '/*.lua', true, true)) do
    local name = vim.fn.fnamemodify(file, ':t:r')
    if name ~= 'init' then
      local req_name = name:match '^%d+%-?(.*)$' or name
      if not package.loaded['plugins.lang.' .. req_name] then
        local fn, err = loadfile(file)
        if not fn then error('loadfile ' .. file .. ': ' .. tostring(err)) end
        fn()
        package.loaded['plugins.lang.' .. req_name] = true
      end
    end
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
