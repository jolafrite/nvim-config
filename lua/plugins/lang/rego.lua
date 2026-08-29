-- Rego (Open Policy Agent) language support (treesitter + LSP config).
local rego_filetypes = { 'rego' }

require('utils').install_with_mason {
  'regols',
  'regal',
}

vim.lsp.config('regols', {
  cmd = { 'regols' },
  filetypes = rego_filetypes,
})

vim.lsp.config('regal', {
  cmd = { 'regal', 'lsp' },
  filetypes = rego_filetypes,
})

-- Tree-sitter parser for Rego.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'rego' })

vim.lsp.enable 'regols'
vim.lsp.enable 'regal'

-- vim: ts=2 sts=2 sw=2 et
