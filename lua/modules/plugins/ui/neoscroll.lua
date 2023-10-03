return {
    ["karb94/neoscroll.nvim"] = {
        lazy = true,
        event = "BufReadPost",
        config = require("ui.neoscroll"),
    }
}
