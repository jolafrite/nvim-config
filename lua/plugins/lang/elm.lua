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

PackageManager.add_with_treesitter { 'elm' }

vim.lsp.enable 'elmls'
