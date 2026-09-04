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
  init_options = {
    onlyAnalyzeProjectsWithOpenFiles = true,
    suggestFromUnimportedLibraries = true,
    closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
  settings = {
    dart = {
      completeFunctionCalls = true,
      showTodos = true,
    },
  },
})

vim.lsp.config('dcm', {
  cmd = { 'dcm', 'start-server', '--client=neovim' },
  filetypes = { 'dart' },
  root_markers = { 'pubspec.yaml', '.git' },
})

vim.lsp.enable 'dcm'

PackageManager.add_with_treesitter { 'dart' }

vim.lsp.enable 'dartls'
