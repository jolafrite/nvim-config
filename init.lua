require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.pack'
require 'plugins'
require 'config.load_lsp'
require 'plugins.lang'

pcall(vim.cmd.colorscheme, "shades-of-purple")

-- vim: ts=2 sts=2 sw=2 et
