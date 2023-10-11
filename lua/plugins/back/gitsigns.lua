return {
    ["lewis6991/gitsigns.nvim"] = {
        lazy = true,
        event = { "BufReadPost" },
        config = require("ui.gitsigns"),
    }
}
