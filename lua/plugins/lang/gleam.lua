

PackageManager.add_formatter('gleam', 'gleam', function(conform)
  conform.formatters.gleam = {
    condition = function() return vim.fn.executable 'gleam' == 1 end,
  }
end)

if vim.fn.executable 'gleam' == 1 then
  vim.lsp.config('gleam', {
    cmd = { 'gleam', 'lsp' },
    filetypes = { 'gleam' },
    root_markers = { 'gleam.toml', 'gleam.json', '.git' },
  })

  PackageManager.add_with_treesitter { 'gleam' }

  vim.lsp.enable 'gleam'
end
