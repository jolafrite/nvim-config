-- Nushell language support (treesitter + LSP config).
require('utils').install_with_mason {
  'nushell',
}

vim.lsp.config('nushell', {
  cmd = { 'nu', '--lsp' },
  filetypes = { 'nu' },
})

-- Tree-sitter parser for Nushell.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'nu' })

vim.lsp.enable 'nushell'

-- vim: ts=2 sts=2 sw=2 et
