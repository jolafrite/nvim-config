require("snacks").setup({
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = false }, -- set in options.lua
	toggle = { map = vim.keymap.set },
	words = { enabled = true },
})