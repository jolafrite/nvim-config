PackageManager.add_with_mason {
  'ember-language-server',
}
PackageManager.add_formatter('glimmer', 'prettierd')

vim.lsp.config('ember', {
  cmd = { 'ember-language-server', '--stdio' },
  filetypes = { 'handlebars', 'typescript', 'javascript' },
  root_markers = { 'ember-cli-build.js', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'glimmer', 'glimmer_javascript', 'glimmer_typescript', 'css' })

vim.lsp.enable 'ember'
