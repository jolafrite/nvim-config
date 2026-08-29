-- Markdown language support (treesitter + LSP config).
--
-- LSP: marksman. Formatters: prettier + markdownlint-cli2 + markdown-toc.
-- Linter: markdownlint-cli2.
require('utils').install_with_mason {
	'marksman',
}

vim.lsp.config('marksman', {
	cmd = { 'marksman', 'server' },
	filetypes = { 'markdown', 'markdown.mdx' },
	root_markers = { '.marksman.toml', '.git' },
})

local conform = require("conform")
conform.formatters_by_ft.markdown =
{ "prettier", "markdownlint-cli2", "markdown-toc" }
conform.formatters_by_ft["markdown.mdx"] =
{ "prettier", "markdownlint-cli2", "markdown-toc" }

local lint = require("lint")
lint.linters_by_ft.markdown = { "markdownlint-cli2" }

vim.lsp.enable 'marksman'

-- vim: ts=2 sts=2 sw=2 et
