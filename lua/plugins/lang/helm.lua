-- Helm chart language support (treesitter + LSP config).
require('utils').install_with_mason {
  'helm-ls',
}

-- Treat templates inside a Helm chart as `helm` so helm_ls and treesitter
-- engage on them.
vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.ya?ml$'] = 'helm',
    ['.*%.tpl$'] = 'helm',
  },
}

vim.lsp.config('helm_ls', {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm' },
  root_markers = { 'Chart.yaml', '.git' },
})

-- Tree-sitter parser for Helm (yaml with go-template).
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'helm' })

vim.lsp.enable 'helm_ls'

-- vim: ts=2 sts=2 sw=2 et
