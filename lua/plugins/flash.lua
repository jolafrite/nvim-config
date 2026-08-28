local gh = require("utils").gh

-- Flash jumps (f/t, etc.) depend on treesitter, so load on the same trigger
-- as treesitter.lua: the first FileType rather than at startup.
require("utils").on_file_types("*", function()
	vim.pack.add({
		gh("folke/flash.nvim"),
	})

	require("flash").setup({})
end)

-- stylua: ignore
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end,
	{ desc = 'Flash' })
vim.keymap.set({ "n", "o", "x" }, "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function()
	require("flash").remote()
end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function()
	require("flash").toggle()
end, { desc = "Toggle Flash Search" })
vim.keymap.set({ "n", "o", "x" }, "<c-space>", function()
	require("flash").treesitter({
		actions = {
			["<c-space>"] = "next",
			["<BS>"] = "prev",
		},
	})
end, { desc = "Treesitter Incremental Selection" })
