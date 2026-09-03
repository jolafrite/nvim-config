local lsp = vim.g.lazyvim_php_lsp or 'phpactor'

PackageManager.add_with_mason {
  lsp,
  'php-cs-fixer',
  'phpcs',
  'php-debug-adapter',
}
PackageManager.add_formatter('php', 'php_cs_fixer')
PackageManager.add_linter('php', 'phpcs')

PackageManager.add_debugger('php', 'php-debug-adapter')

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
