PackageManager.add_with_mason {
  'thriftls',
}

vim.lsp.config('thriftls', {
  cmd = { 'thriftls' },
  filetypes = { 'thrift', 'thrift2' },
})

PackageManager.add_with_treesitter({ 'thrift' })

vim.lsp.enable 'thriftls'
