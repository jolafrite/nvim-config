PackageManager.add_with_mason {
  'erlang_ls',
}

vim.lsp.config('erlangls', {
  cmd = { 'erlang_ls' },
  filetypes = { 'erlang' },
  root_markers = { 'rebar.config', 'erlang.mk', '.git' },
})

PackageManager.add_with_treesitter({ 'erlang' })

vim.lsp.enable 'erlangls'
