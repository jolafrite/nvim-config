PackageManager.add_with_mason {
  'omnisharp',
  'fsautocomplete',
  'csharpier',
  'fantomas',
  'netcoredbg',
}
PackageManager.add_formatter('cs', 'csharpier')
PackageManager.add_formatter('fsharp', 'fantomas')

PackageManager.add_debugger({ 'cs', 'fsharp' }, 'netcoredbg')

vim.lsp.config('omnisharp', {
  cmd = { 'omnisharp', '--languageserver' },
  filetypes = { 'cs', 'vb' },
  root_markers = {
    '*.sln',
    '*.csproj',
    '*.fsproj',
    'omnisharp.json',
    'function.json',
    'paket.dependencies',
    'paket.lock',
  },
  settings = {
    FormattingOptions = { OrganizeImports = true },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableImportCompletion = true,
    },
  },
})

vim.lsp.config('fsautocomplete', {
  cmd = { 'fsautocomplete', '--adaptive-lsp-server-enabled' },
  filetypes = { 'fsharp' },
  root_markers = { '*.fsproj', 'paket.dependencies', 'paket.lock' },
})

PackageManager.add_with_treesitter { 'c_sharp', 'fsharp' }

vim.lsp.enable 'omnisharp'
vim.lsp.enable 'fsautocomplete'
