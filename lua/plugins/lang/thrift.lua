PackageManager.add_with_mason {
  'thriftls',
}

vim.lsp.config('thriftls', {
  cmd = { 'thriftls' },
  filetypes = { 'thrift', 'thrift2' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'thrift' })

vim.lsp.enable 'thriftls'
