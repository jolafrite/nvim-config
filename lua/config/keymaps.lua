local opts = { noremap = false, silent = true }

-- Search current word
local open_url = function(url)
	local command = vim.fn.has("mac") == 1 and "open" or "xdg-open"
	vim.fn.system({ command, url })
end
local searching_brave = function()
	open_url("https://search.brave.com/search?q=" .. vim.fn.expand("<cword>"))
end
vim.keymap.set("n", "<leader>?", searching_brave, {
	noremap = true,
	silent = true,
	desc = "Search Current Word on Brave Search",
})

vim.keymap.set("n", "+", "<C-a>", opts)
vim.keymap.set("n", "-", "<C-x>", opts)

-- delete a word backwards
vim.keymap.set("n", "dw", 'vd"_d')

-- select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

vim.keymap.set("n", "<C-c>", "ciw")

vim.keymap.set("n", "<Up>", "<c-w>k")
vim.keymap.set("n", "<Down>", "<c-w>j")
vim.keymap.set("n", "<Left>", "<c-w>h")
vim.keymap.set("n", "<Right>", "<c-w>l")

vim.keymap.set("n", "<C-m>", "<C-i>", opts)

vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-i>", "<C-i>zz", opts)
vim.keymap.set("n", "<C-o>", "<C-o>zz", opts)
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)
vim.keymap.set("n", "gg", "ggzz", opts)
vim.keymap.set("n", "GG", "GGzz", opts)
vim.keymap.set("n", "%", "%zz", opts)
vim.keymap.set("n", "*", "*zz", opts)
vim.keymap.set("n", "#", "#zz", opts)

-- U for redo
vim.keymap.set("n", "U", "<C-r>", opts)

local linters = function()
	local linters_attached = require("lint").linters_by_ft[vim.bo.filetype]
	local buf_linters = {}

	if not linters_attached then
		vim.notify("No linters attached", { title = "Linter" })
		return
	end

	for _, linter in pairs(linters_attached) do
		table.insert(buf_linters, linter)
	end

	local unique_client_names = table.concat(buf_linters, ", ")
	local linters = string.format("%s", unique_client_names)

	vim.notify(linters, { title = "Linter" })
end
vim.keymap.set("n", "<leader>ciL", linters, { desc = "Lint" })
