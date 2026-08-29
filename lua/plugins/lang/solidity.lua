-- Solidity language support (treesitter + LSP config).
require('utils').install_with_mason {
  'solc',
}

-- `solidity_ls` in nvim-lspconfig wraps `solc`'s built-in LSP mode (solc
-- 0.8.x+). It is only enabled when `solc` is available so this module stays
-- inert for machines without the toolchain.
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

-- Tree-sitter parser for Solidity.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'solidity' })

-- vim: ts=2 sts=2 sw=2 et
