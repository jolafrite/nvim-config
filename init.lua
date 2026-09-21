_G.Utils = require 'utils'

local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

PluginsLoader.load 'plugins'
PackageManager.load()

vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath 'data' .. '/mason/bin'

local function startup_error(title, err)
  vim.schedule(function() vim.notify(tostring(err), vim.log.levels.ERROR, { title = title }) end)
end

local ok_load, load_err = pcall(PackageManager.load)
if not ok_load then startup_error('Plugin manager', load_err) end

local ok_theme, theme_err = pcall(vim.cmd.colorscheme, 'shades-of-purple')
if not ok_theme then
  startup_error('Colorscheme', theme_err)
  pcall(vim.cmd.colorscheme, 'default')
end
