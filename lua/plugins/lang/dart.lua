PackageManager.add_with_mason {
  'dart-debug-adapter',
  'dcm',
}
PackageManager.add_formatter('dart', 'dart_format')
PackageManager.add_snippets 'dart'

vim.lsp.config('dartls', {
  cmd = { 'dart', 'language-server', '--protocol=lsp' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml', '.git' },
})

PackageManager.add_with_treesitter { 'dart' }

vim.lsp.enable 'dartls'
