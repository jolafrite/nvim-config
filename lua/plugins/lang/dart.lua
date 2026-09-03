PackageManager.add_with_mason {
  'dart',
}
PackageManager.add_formatter('dart', 'dart_format')

vim.lsp.config('dartls', {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'dart' })

vim.lsp.enable 'dartls'
