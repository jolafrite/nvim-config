PackageManager.add_with_mason {
  'nil',
  'statix',
}

vim.lsp.config('nil_ls', {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'shell.nix', '.git' },
})

PackageManager.add_formatter('nix', 'nixfmt', function(conform) conform.formatters.nixfmt = { command = 'nixfmt', stdin = true } end)

PackageManager.add_linter('nix', 'statix')

PackageManager.add_with_treesitter { 'nix' }

vim.lsp.enable 'nil_ls'
