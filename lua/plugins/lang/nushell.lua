PackageManager.add_with_mason {
  'nushell',
}

vim.lsp.config('nushell', {
  cmd = { 'nu', '--lsp' },
  filetypes = { 'nu' },
})

PackageManager.add_with_treesitter({ 'nu' })

vim.lsp.enable 'nushell'
