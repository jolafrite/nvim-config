PackageManager.add_with_mason {
  'ember-language-server',
}
PackageManager.add_formatter('glimmer', 'prettierd')

vim.lsp.config('ember', {
  cmd = { 'ember-language-server', '--stdio' },
  filetypes = { 'handlebars', 'typescript', 'javascript' },
  root_markers = { 'ember-cli-build.js', '.git' },
})

PackageManager.add_with_treesitter { 'glimmer', 'glimmer_javascript', 'glimmer_typescript', 'css' }

vim.lsp.enable 'ember'
