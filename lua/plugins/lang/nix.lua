PackageManager.add_with_mason {
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
PackageManager.add_formatter('nix', 'nixfmt')

local lint = require 'lint'
PackageManager.add_linter('nix', 'statix')

PackageManager.add_with_treesitter({ 'nix' })

vim.lsp.enable 'nil_ls'
