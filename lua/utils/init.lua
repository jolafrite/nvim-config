local M = {}

M.gh = require("utils.gh").gh
M.cb = require("utils.gh").cb

M.on_file_types = require("utils.autocmds").on_file_types
M.on_buf_read = require("utils.autocmds").on_buf_read

M.on_lsp_attach = require("utils.lsp").on_lsp_attach

M.install_with_mason = require("utils.install").install_with_mason
M.run_build = require("utils.install").run_build

M.get_filename = require("utils.path").get_filename

M.json = require("utils.json")
M.terminal = require("utils.terminal")
M.inject = require("utils.inject")
M.mini = require("utils.mini")
M.treesitter = require("utils.treesitter")
M.root = require("utils.root")

-- Submodules ported from the KurisuNya manager reference. The PackageManager module
-- calls them as bare globals (`Utils.safecall.now`, `Utils.misc.list_sort_stable`
-- etc.), so they are mounted on the module table and re-exported as a global.
M.safecall = require("utils.safecall")
M.autocmd = require("utils.autocmd")
M.misc = require("utils.misc")
M.os = require("utils.os")

-- Expose as a global so the PackageManager module's bare `Utils.*` lookups resolve.
-- Kept in this module so a single require('utils') call (already done by
-- config/options.lua etc.) registers it.
_G.Utils = M

return M

-- vim: ts=2 sts=2 sw=2 et
