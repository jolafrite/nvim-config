PackageManager.add({
  name = 'lang.typst',
  filetype = { 'typst' },
  config = function()

require('utils').install_with_mason {
  'tinymist',
  'typstyle',
}

vim.lsp.config('tinymist', {
  cmd = { 'tinymist' },
  filetypes = { 'typst' },
  root_markers = { 'typst.toml', '.git' },
  single_file_support = true, -- Fixes LSP attachment in non-Git directories
  settings = {
    formatterMode = 'typstyle',
  },
})

local conform = require 'conform'
conform.formatters_by_ft.typst = { 'typstyle' }
-- `lsp_format = 'prefer'` moved here from the removed nested-{} syntax
-- (conform now errors on nested tables; see :help conform.format).
conform.default_format_opts =
  vim.tbl_deep_extend('force', conform.default_format_opts or {}, { typst = { lsp_format = 'prefer' } })

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'typst' })

vim.lsp.enable 'tinymist'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
