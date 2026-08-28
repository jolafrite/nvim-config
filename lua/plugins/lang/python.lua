-- Python language support (treesitter + LSP config).
--
-- Uses merge-form `vim.lsp.config("pyright", {...})` / `vim.lsp.config("ruff", {...})`
-- so that the base `cmd`/`filetypes` set in `lsp.lua` are preserved (assignment form
-- `vim.lsp.config.X = {}` would replace and discard them).
vim.lsp.config("pyright", {})
vim.lsp.config("ruff", {
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
