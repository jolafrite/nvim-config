-- gleam is not mason-installable; the formatter ships with the language itself
-- and only runs when `gleam` is on PATH.
PackageManager.add_formatter('gleam', 'gleam', function(conform)
  conform.formatters.gleam = {
    condition = function() return vim.fn.executable 'gleam' == 1 end,
  }
end)

-- The LSP runs the gleam CLI (`gleam lsp`), so only enable it when gleam exists.
if vim.fn.executable 'gleam' == 1 then
  vim.lsp.config('gleam', {
    cmd = { 'gleam', 'lsp' },
    filetypes = { 'gleam' },
    root_markers = { 'gleam.toml', 'gleam.json', '.git' },
  })

  PackageManager.add_with_treesitter { 'gleam' }

  vim.lsp.enable 'gleam'
end
