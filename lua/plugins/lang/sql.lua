-- SQL language support (treesitter + LSP config).
require('utils').install_with_mason {
  'sqls',
}

vim.lsp.config('sqls', {
  cmd = { 'sqls' },
  filetypes = { 'sql', 'mysql' },
  root_markers = { 'config.yml' },
  settings = {},
})

local conform = require 'conform'
conform.formatters_by_ft.sql = { 'sqlfluff' }
conform.formatters_by_ft.mysql = { 'sqlfluff' }
conform.formatters_by_ft.plsql = { 'sqlfluff' }

-- This module overrides sqlfluff args to use the ANSI dialect.
conform.formatters.sqlfluff = {
  args = { 'format', '--dialect=ansi', '-' },
}

vim.lsp.enable 'sqls'

-- vim: ts=2 sts=2 sw=2 et
