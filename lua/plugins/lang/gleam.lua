PackageManager.add_with_mason {
  'gleam',
}
PackageManager.add_formatter('gleam', 'gleam')

vim.lsp.config('gleam', {
  cmd = { 'gleam', 'lsp' },
  filetypes = { 'gleam' },
  root_markers = { 'gleam.toml', 'gleam.json', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'gleam' })

vim.lsp.enable 'gleam'
