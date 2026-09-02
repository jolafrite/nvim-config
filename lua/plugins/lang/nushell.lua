require('utils').install_with_mason {
  'nushell',
}

vim.lsp.config('nushell', {
  cmd = { 'nu', '--lsp' },
  filetypes = { 'nu' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'nu' })

vim.lsp.enable 'nushell'

