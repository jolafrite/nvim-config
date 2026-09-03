PackageManager.add_with_mason {
  'prisma-language-server',
}

vim.lsp.config('prismals', {
  cmd = { 'prisma-language-server', '--stdio' },
  filetypes = { 'prisma' },
  root_markers = { 'schema.prisma', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'prisma' })

vim.lsp.enable 'prismals'
