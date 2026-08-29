-- Vue language support (treesitter + LSP config).
--
-- Depends on the typescript/ts_ls config (typescript.lua) for the script
-- blocks; vue-language-server handles the rest.
require('utils').install_with_mason {
  'vue-language-server',
}

vim.lsp.config('vue_ls', {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'vue.config.js', '.git' },
})

-- Tree-sitter parsers for Vue.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'vue', 'css' })

vim.lsp.enable 'vue_ls'

-- vim: ts=2 sts=2 sw=2 et
