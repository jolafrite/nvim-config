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

PackageManager.add_formatter('typst', 'typstyle')

PackageManager.add_formatter(
  'typst',
  'typstyle',
  function(conform) conform.default_format_opts = vim.tbl_deep_extend('force', conform.default_format_opts or {}, { typst = { lsp_format = 'prefer' } }) end
)

PackageManager.add_with_treesitter { 'typst' }

vim.lsp.enable 'tinymist'
