return {
    ["nvim-lualine/lualine.nvim"] =  {
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        config = require("ui.lualine"),
    }
}
