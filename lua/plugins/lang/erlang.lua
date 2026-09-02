require('utils').install_with_mason {
  'erlang_ls',
}

vim.lsp.config('erlangls', {
  cmd = { 'erlang_ls' },
  filetypes = { 'erlang' },
  root_markers = { 'rebar.config', 'erlang.mk', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'erlang' })

vim.lsp.enable 'erlangls'

