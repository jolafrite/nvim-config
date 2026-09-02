require('utils').install_with_mason {
  'taplo',
}

vim.lsp.config('taplo', {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  root_markers = { '.taplo.toml', 'taplo.toml', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'toml' })

local conform = require 'conform'
conform.formatters_by_ft.toml = { 'taplo' }

vim.lsp.enable 'taplo'

