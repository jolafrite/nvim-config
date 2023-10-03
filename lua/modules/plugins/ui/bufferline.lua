return {
    ["akinsho/bufferline.nvim"] = {
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        config = require("ui.bufferline"),
    }
}
