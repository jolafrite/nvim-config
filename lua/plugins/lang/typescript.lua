-- Typescript language support.
--
-- Uses merge-form `vim.lsp.config("ts_ls", {...})` so that the base
-- `cmd`/`filetypes` set in `lsp.lua` are preserved (assignment form
-- `vim.lsp.config.ts_ls = {}` would replace and discard them).
--
-- `typescript-language-server` is unusual in two ways vs. other mason servers:
--   1. It REQUIRES `--stdio` to be passed explicitly in `cmd`. Every other
--      server here (gopls, lua-language-server, ...) is invoked with no
--      args; omitting `--stdio` makes this binary refuse to start with
--      `error: required option '--stdio' not specified`.
--   2. `filetypes` must be a table, not a function -- this Neovim's
--      `vim/lsp.lua:479` rejects a function value for `filetypes`.
require('utils').install_with_mason {
	'oxlint',
	'prettier',
}

vim.lsp.config("ts_ls", {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
})

local conform = require("conform")
conform.formatters.prettier = {
	command = "prettier",
	stdin = true,
}
conform.formatters_by_ft.javascript = { "prettier" }
conform.formatters_by_ft.javascriptreact = { "prettier" }
conform.formatters_by_ft.typescript = { "prettier" }
conform.formatters_by_ft.typescriptreact = { "prettier" }

require("lint").linters_by_ft.javascript = { "oxlint" }
require("lint").linters_by_ft.javascriptreact = { "oxlint" }
require("lint").linters_by_ft.typescript = { "oxlint" }
require("lint").linters_by_ft.typescriptreact = { "oxlint" }

vim.lsp.enable 'ts_ls'

-- vim: ts=2 sts=2 sw=2 et
