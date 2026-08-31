-- depends on typescript.lua for the script blocks
PackageManager.add({
  name = 'lang.vue',
  filetype = { 'vue' },
  config = function()

require('utils').install_with_mason {
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
  end,
})

-- vim: ts=2 sts=2 sw=2 et
