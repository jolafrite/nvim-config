local gh = require("utils").gh

-- Only useful once an LSP attaches, so load lazily instead of at startup.
require("utils").on_lsp_attach(function()
	vim.pack.add({
		gh("Wansmer/symbol-usage.nvim"),
	})

	require("symbol-usage").setup({
		vt_position = "end_of_line",
		text_format = function(symbol)
			if symbol.references then
				local usage = symbol.references <= 1 and "usage" or "usages"
				local num = symbol.references == 0 and "no" or symbol.references
				return string.format(" 󰌹 %s %s", num, usage)
			else
				return ""
			end
		end,
	})
end)
