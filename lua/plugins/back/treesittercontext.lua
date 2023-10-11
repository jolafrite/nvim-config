return {
    ["romgrk/nvim-treesitter-context"] = {
        lazy = true,
        event = "VeryLazy",
        config = require("editor.treesittercontext")
    }
}
