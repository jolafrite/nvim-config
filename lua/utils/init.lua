local M = {}

M.gh = function(repo)
  return "https://github.com/" .. repo
end

M.install_with_mason = require("utils.install").install_with_mason
M.on_buf_read = require("utils.autocmds").on_buf_read
M.on_file_types = require("utils.autocmds").on_file_types
M.root = require("utils.root")
M.run_build = require("utils.install").run_build
M.terminal = require("utils.terminal")
M.treesitter = require("utils.treesitter")

_G.Utils = M

return M

-- vim: ts=2 sts=2 sw=2 et
