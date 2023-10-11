return {
    "catppuccin/nvim",
	name = "catppuccin",
	event = "CursorHold",
	config = function()
		require("plugins/configs/catppuccin")
	end
}
