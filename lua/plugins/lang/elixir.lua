PackageManager.add_with_mason {
  'elixir-ls',
}

vim.lsp.config('elixirls', {
  cmd = { 'elixir-ls' },
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface', 'livebook' },
  root_markers = { 'mix.exs', '.git' },
})

PackageManager.add_linter('elixir', 'credo', function(lint)
  lint.linters.credo = vim.tbl_deep_extend('force', lint.linters.credo or {}, {
    condition = function(ctx) return vim.fs.find({ '.credo.exs' }, { path = ctx.filename, upward = true })[1] ~= nil end,
  })
end)

PackageManager.add_with_treesitter { 'elixir', 'heex', 'eex' }

vim.treesitter.language.register('markdown', 'livebook')

vim.lsp.enable 'elixirls'
