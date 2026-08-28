-- SQL language support (treesitter + LSP config).
vim.lsp.config('sqls',
{})

local conform = require("conform")
conform.formatters_by_ft.sql = { "sqlfluff" }
conform.formatters_by_ft.mysql = { "sqlfluff" }
conform.formatters_by_ft.plsql = { "sqlfluff" }

-- This module overrides sqlfluff args to use the ANSI dialect.
conform.formatters.sqlfluff = {
	args = { "format", "--dialect=ansi", "-" },
}
