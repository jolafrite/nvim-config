PackageManager.add_with_mason {
  'vue-language-server',
}

vim.lsp.config('vue_ls', {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'vue.config.js', '.git' },
})

PackageManager.add_with_treesitter({ 'vue', 'css' })

vim.lsp.enable 'vue_ls'
