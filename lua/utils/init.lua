local M = {}

---@param repo string
---@return string
M.gh = function(repo) return 'https://github.com/' .. repo end

-- vim.isnil() tests nil or vim.NIL
M.isnil = function(v) local ok, isnil = pcall(vim.isnil, v) return ok and isnil or v == nil end

-- vim.nonnil() returns first non-nil argument
M.nonnil = function(...) local ok, result = pcall(vim.nonnil, ...) return ok and result or select(1, ...) end

-- vim.npcall() calls fn in protected mode, returns nil on error
M.npcall = function(fn, ...)
  if vim.npcall then return vim.npcall(fn, ...) end
  local ok, result = pcall(fn, ...)
  return ok and result or nil
end

-- vim.keycode() returns structured info as return value 2
M.keycode = function(keys) local ok, result = pcall(vim.keycode, keys) return ok and result or keys end

M.log = require 'utils.log'
M.install_with_mason = require('utils.install').install_with_mason
M.on_buf_read = require('utils.autocmds').on_buf_read
M.on_file_types = require('utils.autocmds').on_file_types
M.package_manager = require 'utils.package_manager'
M.plugins_loader = require 'utils.plugins_loader'
M.root = require 'utils.root'
M.run_build = require('utils.install').run_build
M.terminal = require 'utils.terminal'
M.treesitter = require 'utils.treesitter'

return M
