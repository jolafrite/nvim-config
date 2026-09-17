PackageManager.add_with_mason {
  'nil',
  'statix',
  'nixfmt',
}

vim.lsp.config('nil_ls', {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'shell.nix', '.git' },
})

-- conform's built-in nixfmt is `nixfmt` on stdin; no override needed.
PackageManager.add_formatter('nix', 'nixfmt')

PackageManager.add_linter('nix', 'statix')

PackageManager.add_with_treesitter { 'nix' }

vim.lsp.enable 'nil_ls'
