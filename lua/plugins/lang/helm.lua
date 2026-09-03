PackageManager.add_with_mason {
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

PackageManager.add_with_treesitter({ 'helm' })

vim.lsp.enable 'helm_ls'
