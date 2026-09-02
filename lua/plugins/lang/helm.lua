require('utils').install_with_mason {
  'helm-ls',
}


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

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'helm' })

vim.lsp.enable 'helm_ls'

