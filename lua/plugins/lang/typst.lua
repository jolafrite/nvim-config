PackageManager.add_with_mason {
  'tinymist',
  'typstyle',
}

vim.lsp.config('tinymist', {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { 'typst.toml', '.git' },
  single_file_support = true,
  settings = {
    formatterMode = 'typstyle',
  },
})

PackageManager.add_with_treesitter { 'typst' }

-- tinymist formats through LSP (see formatterMode below); register typstyle as
-- the CLI fallback in the same call so the ft list keeps a single entry.
PackageManager.add_formatter('typst', 'typstyle', function(conform)
  conform.default_format_opts = vim.tbl_deep_extend('force', conform.default_format_opts or {}, { typst = { lsp_format = 'prefer' } })
end)

vim.lsp.enable 'tinymist'
