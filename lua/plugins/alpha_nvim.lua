return {
    "goolord/alpha-nvim",
	event = "BufEnter",
	config = function()
		require("plugins.configs.alpha_nvim")
	end
}
