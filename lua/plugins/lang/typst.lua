require('utils').install_with_mason {
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

local conform = require 'conform'
conform.formatters_by_ft.typst = { 'typstyle' }


conform.default_format_opts =
  vim.tbl_deep_extend('force', conform.default_format_opts or {}, { typst = { lsp_format = 'prefer' } })

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'typst' })

vim.lsp.enable 'tinymist'

