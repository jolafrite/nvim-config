-- Elm language support (treesitter + LSP config).
require('utils').install_with_mason {
  'elm-language-server',
  'elm-format',
}

vim.lsp.config('elmls', {
  cmd = { 'elm-language-server' },
  filetypes = { 'elm' },
  root_markers = { 'elm.json', 'elm-package.json', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.elm = { 'elm_format' }

-- Tree-sitter parser for Elm.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'elm' })

vim.lsp.enable 'elmls'

-- vim: ts=2 sts=2 sw=2 et
