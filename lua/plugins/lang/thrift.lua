PackageManager.add({
  name = 'lang.thrift',
  filetype = { 'thrift', 'thrift2' },
  config = function()

require('utils').install_with_mason {
  'thriftls',
}

vim.lsp.config('thriftls', {
  cmd = { 'thriftls' },
  filetypes = { 'thrift', 'thrift2' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'thrift' })

vim.lsp.enable 'thriftls'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
