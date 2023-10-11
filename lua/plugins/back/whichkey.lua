return {
    ["folke/which-key.nvim"] = {
        lazy = true,
        event = "VeryLazy",
        config = require("tool.whichkey"),
    }
}
