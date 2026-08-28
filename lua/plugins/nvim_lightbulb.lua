local gh = require("utils").gh

-- Only needed when an LSP attaches with quickfix/refactor actions, so load
-- it lazily instead of at startup. utils.on_lsp_attach fires once on the
-- first LSPAttach event.
require("utils").on_lsp_attach(function()
	vim.pack.add({
		gh("kosayoda/nvim-lightbulb"),
	})

	require("nvim-lightbulb").setup({
		autocmd = { enabled = true },
		sign = { enabled = true, text = "󰰀" },
		action_kinds = { "quickfix", "refactor" },
		ignore = {
			actions_without_kind = true,
		},
	})
end)
