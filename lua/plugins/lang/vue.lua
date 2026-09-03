PackageManager.add_with_mason {
  'vue-language-server',
}

vim.lsp.config('vue_ls', {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'vue.config.js', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'vue', 'css' })

vim.lsp.enable 'vue_ls'
