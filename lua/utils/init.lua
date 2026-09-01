local M = {}

M.autocmds = require 'utils.autocmds'
M.cb = require('utils.gh').cb
M.get_filename = require('utils.path').get_filename
M.gh = require('utils.gh').gh
M.inject = require 'utils.inject'
M.install_with_mason = require('utils.install').install_with_mason
M.json = require 'utils.json'
M.mini = require 'utils.mini'
M.misc = require 'utils.misc'
M.on_buf_read = require('utils.autocmds').on_buf_read
M.on_file_types = require('utils.autocmds').on_file_types
M.on_lsp_attach = require('utils.lsp').on_lsp_attach
M.os = require 'utils.os'
M.root = require 'utils.root'
M.run_build = require('utils.install').run_build
M.safecall = require 'utils.safecall'
M.terminal = require 'utils.terminal'
M.treesitter = require 'utils.treesitter'

_G.Utils = M

return M

-- vim: ts=2 sts=2 sw=2 et
