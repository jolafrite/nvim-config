return {
	"delphinus/cellwidths.nvim",
	event = "BufEnter",
	config = function()
		require("plugins/configs/cellwidths_nvim")
	end
}
