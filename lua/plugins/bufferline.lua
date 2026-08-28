local gh = require("utils").gh

vim.pack.add({
	gh("akinsho/bufferline.nvim"),
})

require("bufferline").setup({
	options = {
		-- stylua: ignore
		close_command = function(n) Snacks.bufdelete(n) end,
		-- stylua: ignore
		right_mouse_command = function(n) Snacks.bufdelete(n) end,
		diagnostics = "nvim_lsp",
		always_show_bufferline = false,
		diagnostics_indicator = function(_, _, diag)
			local ret = (diag.error and " " .. diag.error .. " " or "")
					.. (diag.warning and " " .. diag.warning or "")
			return vim.trim(ret)
		end,
		offsets = {
			{
				filetype = "neo-tree",
				text = "Neo-tree",
				highlight = "Directory",
				text_align = "left",
			},
			{
				filetype = "snacks_layout_box",
			},
		},
	},
})

local nvim_bufferline = function() pcall(require("bufferline").setup) end
-- Fix bufferline when restoring a session

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
	callback = function()
		vim.schedule(function()
			pcall(nvim_bufferline)
		end)
	end,
})

-- stylua: ignore
vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",
	{ desc = "Toggle Pin" })
vim.keymap.set(
	"n",
	"<leader>bP",
	"<Cmd>BufferLineGroupClose ungrouped<CR>",
	{ desc = "Delete Non-Pinned Buffers" }
)
vim.keymap.set(
	"n",
	"<leader>br",
	"<Cmd>BufferLineCloseRight<CR>",
	{ desc = "Delete Buffers to the Right" }
)
vim.keymap.set(
	"n",
	"<leader>bl",
	"<Cmd>BufferLineCloseLeft<CR>",
	{ desc = "Delete Buffers to the Left" }
)
vim.keymap.set(
	{ "n", "x" },
	"<S-h>",
	"<cmd>BufferLineCyclePrev<cr>",
	{ desc = "Prev Buffer" }
)
vim.keymap.set(
	{ "n", "x" },
	"<S-l>",
	"<cmd>BufferLineCycleNext<cr>",
	{ desc = "Next Buffer" }
)
vim.keymap.set(
	"n",
	"[b",
	"<cmd>BufferLineCyclePrev<cr>",
	{ desc = "Prev Buffer" }
)
vim.keymap.set(
	"n",
	"]b",
	"<cmd>BufferLineCycleNext<cr>",
	{ desc = "Next Buffer" }
)
vim.keymap.set(
	"n",
	"[B",
	"<cmd>BufferLineMovePrev<cr>",
	{ desc = "Move buffer prev" }
)
vim.keymap.set(
	"n",
	"]B",
	"<cmd>BufferLineMoveNext<cr>",
	{ desc = "Move buffer next" }
)
vim.keymap.set(
	"n",
	"<leader>bj",
	"<cmd>BufferLinePick<cr>",
	{ desc = "Pick Buffer" }
)
