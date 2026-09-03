PackageManager.add_with_mason {
  'elm-language-server',
  'elm-format',
}
PackageManager.add_formatter('elm', 'elm_format')

vim.lsp.config('elmls', {
  cmd = { 'elm-language-server' },
  filetypes = { 'elm' },
  root_markers = { 'elm.json', 'elm-package.json', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'elm' })

vim.lsp.enable 'elmls'
