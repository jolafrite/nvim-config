require('utils').install_with_mason {
  'ember-language-server',
}

vim.lsp.config('ember', {
  cmd = { 'ember-language-server', '--stdio' },
  filetypes = { 'handlebars', 'typescript', 'javascript' },
  root_markers = { 'ember-cli-build.js', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.glimmer = { 'prettierd' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'glimmer', 'glimmer_javascript', 'glimmer_typescript', 'css' })

vim.lsp.enable 'ember'

