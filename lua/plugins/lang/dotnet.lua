PackageManager.add_with_mason {
  'omnisharp',
  'fsautocomplete',
  'csharpier',
  'fantomas',
  'netcoredbg',
}
PackageManager.add_formatter('cs', 'csharpier')
PackageManager.add_formatter('fsharp', 'fantomas')

-- netcoredbg is installed by mason above; wire the adapter and a launch
-- configuration for both C# and F#.
PackageManager.add_debugger({ 'cs', 'fsharp' }, 'netcoredbg', function(dap)
  local netcoredbg = vim.fn.exepath 'netcoredbg'
  if netcoredbg == '' then return end

  dap.adapters.netcoredbg = {
    type = 'executable',
    command = netcoredbg,
    args = { '--interpreter=vscode' },
    options = { detached = false },
  }

  for _, ft in ipairs { 'cs', 'fsharp' } do
    dap.configurations[ft] = {
      {
        type = 'netcoredbg',
        name = 'Launch file',
        request = 'launch',
        program = function() return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file') end,
        cwd = '${workspaceFolder}',
      },
    }
  end
end)

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
