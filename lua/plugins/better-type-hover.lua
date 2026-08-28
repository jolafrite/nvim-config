local gh = require("utils").gh

require("utils").on_file_types({ "typescript", "typescriptreact" }, function(ev)
	vim.pack.add({
		gh("Sebastian-Nielsen/better-type-hover"),
	})

	local ok, bth = pcall(require, "better-type-hover")
	if not ok then
		return
	end

	bth.config = bth.config or {}

	vim.keymap.set("n", "<C-P>", bth.better_type_hover, {
		buffer = ev.buf,
		desc = "Better type hover",
	})
end)
