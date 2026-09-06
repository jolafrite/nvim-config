require 'utils'
_G.Utils = require 'utils'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

PluginsLoader.load 'plugins'
PackageManager.load()

-- Neovim 0.13: vim.env now expands ~ and env vars in vim.env assignments
vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('data') .. '/mason/bin'

vim.cmd.colorscheme 'shades-of-purple'
