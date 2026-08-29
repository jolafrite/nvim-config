-- Typst language support (tinymist LSP + typstyle formatter).
require('utils').install_with_mason {
  'tinymist',
  'typstyle',
}

vim.lsp.config('tinymist', {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { 'typst.toml', '.git' },
  single_file_support = true, -- Fixes LSP attachment in non-Git directories
  settings = {
    formatterMode = 'typstyle',
  },
})

local conform = require 'conform'
conform.formatters_by_ft.typst = { { 'typstyle', lsp_format = 'prefer' } }

-- Tree-sitter parser for Typst.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'typst' })

vim.lsp.enable 'tinymist'

-- vim: ts=2 sts=2 sw=2 et
