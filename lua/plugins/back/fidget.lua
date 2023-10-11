return {
    ["j-hui/fidget.nvim"] = {
        lazy = true,
        event = "BufReadPost",
        tag = "legacy",
        config = require("ui.fidget"),
    }
}
