PackageManager.add({
  name = 'lang.nushell',
  filetype = { 'nu' },
  config = function()

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
  end,
})

-- vim: ts=2 sts=2 sw=2 et
