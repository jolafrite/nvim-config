require("nvim-lightbulb").setup({
	autocmd = { enabled = true },
	sign = { enabled = true, text = "󰰀" },
	action_kinds = { "quickfix", "refactor" },
	ignore = {
		actions_without_kind = true,
	},
})
