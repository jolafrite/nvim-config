require("conform").setup({
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
