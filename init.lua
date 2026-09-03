require 'utils'
_G.Utils = require 'utils'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

PluginsLoader.load 'plugins'
PackageManager.load()

pcall(vim.cmd.colorscheme, 'shades-of-purple')
