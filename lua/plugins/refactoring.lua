local gh = require("utils").gh

-- Refactor menu driven by LSP capabilities. Only meaningful once an LSP is
-- attached, so load on first LSPAttach rather than at startup.
require("utils").on_lsp_attach(function()
	vim.pack.add({
		gh("theprimeagen/refactoring.nvim"),
	})

	require("refactoring").setup({})
end)
