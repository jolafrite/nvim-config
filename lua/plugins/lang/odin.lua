require('utils').install_with_mason {
  'ols',
  'odinfmt',
}

vim.lsp.config('ols', {
  cmd = { 'ols' },
  filetypes = { 'odin' },
  root_markers = { 'ols.json', 'odin.toml', '.git' },
  init_options = {
    collections = {},
    enable_document_symbols = true,
    enable_semantic_tokens = true,
    enable_inlay_hints = true,
  },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'odin' })

local conform = require 'conform'
conform.formatters_by_ft.odin = { 'odinfmt' }

vim.lsp.enable 'ols'

