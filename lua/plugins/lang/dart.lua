require('utils').install_with_mason {
  'dart',
}

vim.lsp.config('dartls', {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.dart = { 'dart_format' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'dart' })

vim.lsp.enable 'dartls'

-- vim: ts=2 sts=2 sw=2 et
