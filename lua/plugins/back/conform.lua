return {
	["stevearc/conform.nvim"] = {
		lazy = true,
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
		config = require("editor.conform")
	}
}
