-- TOML language support (treesitter + LSP config).
require("utils").install_with_mason({
	"taplo",
})

vim.lsp.config("taplo", {
	cmd = { "taplo", "lsp", "stdio" },
	filetypes = { "toml" },
	root_markers = { ".taplo.toml", "taplo.toml", ".git" },
})

-- Tree-sitter parser for TOML.
local TS = require("nvim-treesitter")
pcall(TS.install, { "toml" })

local conform = require("conform")
conform.formatters.taplo_fmt = {
	command = "taplo",
	stdin = true,
	args = { "fmt", "-" },
}
conform.formatters_by_ft.toml = { "taplo_fmt" }

vim.lsp.enable("taplo")

-- vim: ts=2 sts=2 sw=2 et
