require('utils').install_with_mason {
  'helm-ls',
}

-- chart templates get the helm filetype
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

-- vim: ts=2 sts=2 sw=2 et
