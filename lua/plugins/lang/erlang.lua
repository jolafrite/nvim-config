-- Erlang language support (treesitter + LSP config).
require('utils').install_with_mason {
  'erlang_ls',
}

vim.lsp.config('erlangls', {
  cmd = { 'erlang_ls' },
  filetypes = { 'erlang' },
  root_markers = { 'rebar.config', 'erlang.mk', '.git' },
})

-- Tree-sitter parser for Erlang.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'erlang' })

vim.lsp.enable 'erlangls'

-- vim: ts=2 sts=2 sw=2 et
