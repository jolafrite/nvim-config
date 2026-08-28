-- Re-exports the purpose-grouped modules in lua/utils/. Nothing here is
-- implemented: each function lives in its own file so consumers can require
-- the single module they need without pulling in the whole package.
local M = {}

M.gh = require('utils.gh').gh
M.cb = require('utils.gh').cb

M.on_file_types = require('utils.autocmds').on_file_types
M.on_buf_read = require('utils.autocmds').on_buf_read

M.on_lsp_attach = require('utils.lsp').on_lsp_attach
M.get_lua_filenames_without_extension = require('utils.lsp')
.get_lua_filenames_without_extension

M.install_with_mason = require('utils.install').install_with_mason
M.run_build = require('utils.install').run_build

M.get_filename = require('utils.path').get_filename

M.json = require('utils.json')
M.terminal = require('utils.terminal')
M.inject = require('utils.inject')
M.mini = require('utils.mini')
M.treesitter = require('utils.treesitter')
M.root = require('utils.root')

return M

-- vim: ts=2 sts=2 sw=2 et
