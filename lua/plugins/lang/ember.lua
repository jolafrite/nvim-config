PackageManager.add({
  name = 'lang.ember',
  filetype = { 'handlebars', 'glimmer' },
  config = function()

require('utils').install_with_mason {
  'ember-language-server',
}

vim.lsp.config('ember', {
  cmd = { 'ember-language-server', '--stdio' },
  filetypes = { 'handlebars', 'typescript', 'javascript' },
  root_markers = { 'ember-cli-build.js', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.glimmer = { 'prettier' }

-- glimmer embedding bundles JS/TS; also install their parsers (typescript.lua is
-- lazy now, so they aren't guaranteed present otherwise).
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'glimmer', 'glimmer_javascript', 'glimmer_typescript', 'css', 'typescript', 'javascript' })

vim.lsp.enable 'ember'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
