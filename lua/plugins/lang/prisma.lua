-- Prisma language support (treesitter + LSP config).
require('utils').install_with_mason {
  'prisma-language-server',
}

vim.lsp.config('prismals', {
  cmd = { 'prisma-language-server', '--stdio' },
  filetypes = { 'prisma' },
  root_markers = { 'schema.prisma', '.git' },
})

-- Tree-sitter parser for Prisma.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'prisma' })

vim.lsp.enable 'prismals'

-- vim: ts=2 sts=2 sw=2 et
