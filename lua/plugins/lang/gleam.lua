-- Gleam language support (treesitter + LSP config).
require('utils').install_with_mason {
  'gleam',
}

vim.lsp.config('gleam', {
  cmd = { 'gleam', 'lsp' },
  filetypes = { 'gleam' },
  root_markers = { 'gleam.toml', 'gleam.json', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.gleam = { 'gleam' }

-- Tree-sitter parser for Gleam.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'gleam' })

vim.lsp.enable 'gleam'

-- vim: ts=2 sts=2 sw=2 et
