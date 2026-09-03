PackageManager.add_with_mason {
  'taplo',
}
PackageManager.add_formatter('toml', 'taplo')

vim.lsp.config('taplo', {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  root_markers = { '.taplo.toml', 'taplo.toml', '.git' },
})

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'toml' })

vim.lsp.enable 'taplo'
