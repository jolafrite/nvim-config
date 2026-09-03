PackageManager.add_with_mason {
  'omnisharp',
  'fsautocomplete',
  'csharpier',
  'fantomas',
}
PackageManager.add_formatter({ 'cs', 'fsharp' }, { 'csharpier', 'fantomas' })

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
  enable_roslyn_analyzers = true,
  organize_imports_on_format = true,
  enable_import_completion = true,
})

vim.lsp.config('fsautocomplete', {
  cmd = { 'fsautocomplete', '--adaptive-lsp-server-enabled' },
  filetypes = { 'fsharp' },
  root_markers = { '*.fsproj', 'paket.dependencies', 'paket.lock' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'c_sharp', 'fsharp' })

vim.lsp.enable 'omnisharp'
vim.lsp.enable 'fsautocomplete'
