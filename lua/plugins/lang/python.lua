-- Python language support (treesitter + LSP config).
--
-- Uses merge-form `vim.lsp.config("pyright", {...})` / `vim.lsp.config("ruff", {...})`
-- so that the base `cmd`/`filetypes` set in `lsp.lua` are preserved (assignment form
-- `vim.lsp.config.X = {}` would replace and discard them).
require("utils").install_with_mason({
	"pyright",
	"ruff",
})

vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyrightconfig.json",
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		".git",
	},
	settings = {
		pyright = { disableTaggedHints = true },
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

vim.lsp.config("ruff", {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	cmd_env = { RUFF_TRACE = "messages" },
	init_options = {
		settings = {
			logLevel = "error",
		},
	},
})

require("snacks").util.lsp.on({ name = "ruff" }, function(_, client)
	-- Disable hover in favor of Pyright
	client.server_capabilities.hoverProvider = false
end)
-- Tree-sitter parser for Python.
local TS = require("nvim-treesitter")
pcall(TS.install, { "python" })

local conform = require("conform")
conform.formatters.ruff = {
	command = "ruff",
	stdin = true,
	args = { "format", "-" },
}
conform.formatters_by_ft.python = { "ruff" }

require("lint").linters_by_ft.python = { "ruff", "mypy", "flake8" }

vim.lsp.enable("pyright")
vim.lsp.enable("ruff")

-- vim: ts=2 sts=2 sw=2 et
