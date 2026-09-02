require('utils').install_with_mason {
  'solc',
}


if vim.fn.executable 'solc' == 1 then
  vim.lsp.config('solidity_ls', {
    cmd = { 'solc', '--lsp' },
    filetypes = { 'solidity' },
    root_markers = { 'foundry.toml', 'hardhat.config.js', 'hardhat.config.ts', '.git' },
  })
  vim.lsp.enable 'solidity_ls'
end

local conform = require 'conform'
conform.formatters_by_ft.solidity = { 'forge_fmt' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'solidity' })

