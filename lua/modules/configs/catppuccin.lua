return function()
	local transparent_background = false -- Set background transparency here!

    local config = {
		flavour = "mocha", -- Can be one of: latte, frappe, macchiato, mocha
        background = { light = "latte", dark = "mocha" },
        dim_inactive = {
			enabled = false,
			-- Dim inactive splits/windows/buffers.
			-- NOT recommended if you use old palette (a.k.a., mocha).
			shade = "dark",
			percentage = 0.15,
		},
        transparent_background = transparent_background,
    }

    require("catppuccin").setup(config)
end
