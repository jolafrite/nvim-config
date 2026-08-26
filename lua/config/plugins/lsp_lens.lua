require("lsp-lens").setup({
	sections = {
		definition = false,
		references = function(count)
			return "󰌹 Ref: " .. count
		end,
		implements = function(count)
			return "󰡱 Imp: " .. count
		end,
		git_authors = false,
	},
})
