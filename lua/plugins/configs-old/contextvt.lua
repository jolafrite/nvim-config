return function()
    local icons = {
		misc = require("plugins.utils.icons").get("misc"),
	}

    require("nvim_context_vt").setup({
        prefix = icons.misc.Arrow
    })
end
