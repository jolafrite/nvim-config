-- Hoisted so `helm` is detectable before the spec's filetype trigger fires.
vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.ya?ml$'] = 'helm',
    ['.*%.tpl$'] = 'helm',
  },
}

PackageManager.add({
  name = 'lang.helm',
  filetype = { 'helm' },
  config = function()

require('utils').install_with_mason {
  'helm-ls',
}

vim.lsp.config('helm_ls', {
  cmd = { 'helm_ls', 'serve' },
  filetypes = { 'helm' },
  root_markers = { 'Chart.yaml', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'helm' })

vim.lsp.enable 'helm_ls'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
