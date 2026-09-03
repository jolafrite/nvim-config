local rego_filetypes = { 'rego' }

PackageManager.add_with_mason {
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

PackageManager.add_with_treesitter({ 'rego' })

vim.lsp.enable 'regols'
vim.lsp.enable 'regal'
