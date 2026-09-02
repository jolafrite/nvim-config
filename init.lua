require 'utils'
_G.Utils = require 'utils'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'utils.package_manager'
require 'plugins'

pcall(vim.cmd.colorscheme, 'shades-of-purple')
