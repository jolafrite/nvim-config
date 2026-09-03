PackageManager.add_with_mason {
  'prisma-language-server',
}

vim.lsp.config('prismals', {
  cmd = { 'prisma-language-server', '--stdio' },
  filetypes = { 'prisma' },
  root_markers = { 'schema.prisma', '.git' },
})

PackageManager.add_with_treesitter { 'prisma' }

vim.lsp.enable 'prismals'
