PackageManager.add_with_mason {
  'html-lsp',
  'prettierd',
  'htmlhint',
}

PackageManager.add_formatter('html', 'prettierd')
PackageManager.add_linter('html', 'htmlhint')

PackageManager.add_snippets 'html'

vim.lsp.config('html', {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = { 'html' },
  root_markers = { 'package.json', '.git' },
})

PackageManager.add_with_treesitter { 'html' }

vim.lsp.enable 'html'
