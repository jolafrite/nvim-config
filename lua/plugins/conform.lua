local gh = require("utils").gh

vim.pack.add({
	gh("stevearc/conform.nvim"),
})

-- Format on save.
--
-- `conform.format_on_save` is consumed once during setup(); it registers a
-- BufWritePre autocmd but is not exposed as a module field, so it can't be
-- toggled at runtime. We register our own BufWritePre autocmd instead and gate
-- toggled by <leader>cF (defined below).
--
-- `format_after_save` is disabled here: conform runs format_on_save synchronously
-- before the write, so an additional async pass would double-format. The
-- BufWritePre autocmd below calls conform.format({ async = false }).
--
-- Disabled buffers are tracked in `vim.b.conform_formatting`, so a buffer can
-- be excluded without flipping the global flag.

local conform = require("conform")

local M = {}

M.format_on_save = function(bufnr)
	if vim.g.conform_format_on_save == false then
		return false
	end
	if vim.b[bufnr or 0].conform_formatting == true then
		return false
	end
	return true
end

M.toggle = function()
	vim.g.conform_format_on_save = not M.is_on()
end

M.is_on = function()
	return vim.g.conform_format_on_save ~= false
end

conform.setup({
	formatters_by_ft = {
		go = { "gocondense" },
	},
	formatters = {
		gocondense = {
			command = "gocondense",
			stdin = true,
		},
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Format on save (toggleable via <leader>cF)",
	pattern = "*",
	group = vim.api.nvim_create_augroup("ConformOnSave", { clear = true }),
	callback = function(args)
		if
				not vim.api.nvim_buf_is_valid(args.buf)
				or vim.bo[args.buf].buftype ~= ""
		then
			return
		end
		if not M.format_on_save(args.buf) then
			return
		end
		conform.format({ buf = args.buf, async = false, timeout_ms = 1000 })
	end,
})
-- Keymaps (kept here, next to the conform setup they configure, rather than
-- toggled by <leader>cF (defined just below).
vim.keymap.set({ 'n', 'x' }, '<leader>cf', function()
	require('conform').format { force = true }
end, { desc = 'Format' })

-- Toggle format on save. `M.toggle` flips vim.g.conform_format_on_save, which
-- the BufWritePre autocmd above gates on.
vim.keymap.set('n', '<leader>cF', M.toggle, { desc = 'Toggle format on save' })

return M
