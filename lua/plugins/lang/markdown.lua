-- Markdown language support (treesitter + LSP config).
--
-- LSP: marksman. Formatters: prettier + markdownlint-cli2 + markdown-toc.
-- Linter: markdownlint-cli2.
vim.lsp.config("marksman", {})
local conform = require("conform")
conform.formatters_by_ft.markdown =
	{ "prettier", "markdownlint-cli2", "markdown-toc" }
conform.formatters_by_ft["markdown.mdx"] =
	{ "prettier", "markdownlint-cli2", "markdown-toc" }

local lint = require("lint")
lint.linters_by_ft.markdown = { "markdownlint-cli2" }
-- Tree-sitter parsers for Markdown.
local TS = require("nvim-treesitter")
pcall(TS.install, { "markdown", "markdown_inline" })
