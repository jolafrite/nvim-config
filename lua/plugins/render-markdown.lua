local gh = require("utils").gh

-- Markdown rendering (headings, code blocks, checkboxes). Only useful on
-- markdown buffers, so load on first FileType match rather than at startup.
require("utils").on_file_types("markdown", function()
	vim.pack.add({
		gh("MeanderingProgrammer/render-markdown.nvim"),
	})

	require("render-markdown").setup({
		code = {
			sign = false,
			width = "block",
			right_pad = 1,
		},
		heading = {
			sign = false,
			icons = {},
		},
		checkbox = {
			enabled = false,
		},
	})
end)
