require 'utils'
_G.Utils = require 'utils'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Neovim 0.13: vim.pack-manifest support — the lock file pins all plugins
-- declaratively. vim.pack can consume it for install/upgrade operations.
if vim.pack and vim.pack.set_manifest then
  pcall(vim.pack.set_manifest, 'nvim-pack-lock.json')
end

PluginsLoader.load 'plugins'
PackageManager.load()

-- Neovim 0.13: vim.env now expands ~ and env vars in vim.env assignments
vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('data') .. '/mason/bin'

vim.cmd.colorscheme 'shades-of-purple'
