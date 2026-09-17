_G.Utils = require 'utils'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

PluginsLoader.load 'plugins'
PackageManager.load()

vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath 'data' .. '/mason/bin'

-- Report failures as notifications instead of a blocking hit-enter prompt
-- (with 'cmdheight' 0 the messages pager swallows them as "Press any key").
local function startup_error(title, err)
  vim.schedule(function()
    vim.notify(tostring(err), vim.log.levels.ERROR, { title = title })
  end)
end

local ok_load, load_err = pcall(PackageManager.load)
if not ok_load then startup_error('Plugin manager', load_err) end

local ok_theme, theme_err = pcall(vim.cmd.colorscheme, 'shades-of-purple')
if not ok_theme then
  startup_error('Colorscheme', theme_err)
  pcall(vim.cmd.colorscheme, 'default')
end
