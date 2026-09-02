require('utils').install_with_mason {
  'nil',
  'statix',
}

vim.lsp.config('nil_ls', {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'shell.nix', '.git' },
})

local conform = require 'conform'
conform.formatters.nixfmt = { command = 'nixfmt', stdin = true }
conform.formatters_by_ft.nix = { 'nixfmt' }

local lint = require 'lint'
lint.linters_by_ft.nix = { 'statix' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'nix' })

vim.lsp.enable 'nil_ls'

