PackageManager.add({
  name = 'lang.gleam',
  filetype = { 'gleam' },
  config = function()

require('utils').install_with_mason {
  'gleam',
}

vim.lsp.config('gleam', {
  cmd = { 'gleam', 'lsp' },
  filetypes = { 'gleam' },
  root_markers = { 'gleam.toml', 'gleam.json', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.gleam = { 'gleam' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'gleam' })

vim.lsp.enable 'gleam'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
