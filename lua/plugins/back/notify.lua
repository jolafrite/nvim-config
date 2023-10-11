return {
    ["rcarriga/nvim-notify"] = {
        lazy = true,
        event = "VeryLazy",
        config = require("ui.notify"),
    }
}
