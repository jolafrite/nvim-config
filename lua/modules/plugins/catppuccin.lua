return {
    {
        "catppuccin/nvim",
        lazy = true,
	    name = "catppuccin",
	    event = "CursorHold",
	    config = require("catppuccin"),
    }
}
