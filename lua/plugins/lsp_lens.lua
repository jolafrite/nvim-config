local gh = require("utils").gh

-- LSP reference-count lens in the signcolumn. Needs an attached LSP, so
-- load on first LSPAttach instead of at startup.
require("utils").on_lsp_attach(function()
	vim.pack.add({
		gh("VidocqH/lsp-lens.nvim"),
	})

	require("lsp-lens").setup({
		sections = {
			definition = false,
			references = function(count)
				return "󰌹 Ref: " .. count
			end,
			implements = function(count)
				return "󰡱 Imp: " .. count
			end,
			git_authors = false,
		},
	})
end)
