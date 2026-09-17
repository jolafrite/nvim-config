local lsp = vim.g.lazyvim_php_lsp or 'phpactor'

PackageManager.add_with_mason {
  lsp,
  'php-cs-fixer',
  'phpcs',
  'php-debug-adapter',
}
PackageManager.add_formatter('php', 'php_cs_fixer')
PackageManager.add_linter('php', 'phpcs')

-- php-debug-adapter is installed by mason above; it is a node based DAP
-- extension, so resolve its entry point through mason.
PackageManager.add_debugger('php', 'php-debug-adapter', function(dap)
  local adapter = require('utils').mason_path('php-debug-adapter', 'extension', 'out', 'phpDebug.js')
  if not adapter or vim.fn.filereadable(adapter) == 0 or vim.fn.executable 'node' == 0 then return end

  dap.adapters.php = { type = 'executable', command = 'node', args = { adapter } }
  dap.configurations.php = {
    { type = 'php', request = 'launch', name = 'Listen for Xdebug', port = 9000 },
  }
end)

PackageManager.add_snippets 'php'

if lsp == 'phpactor' then
  vim.lsp.config('phpactor', {
    cmd = { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    root_markers = { 'composer.json', '.git' },
  })
  vim.lsp.enable 'phpactor'
else
  vim.lsp.config('intelephense', {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_markers = { 'composer.json', '.git' },
  })
  vim.lsp.enable 'intelephense'
end

PackageManager.add_with_treesitter { 'php' }
