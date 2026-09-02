local M = {}

---@param repo string
---@return string
M.gh = function(repo) return 'https://github.com/' .. repo end

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
