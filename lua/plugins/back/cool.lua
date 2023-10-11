return {
    ["romainl/vim-cool"] = {
        lazy = true,
        event = { "CursorMoved", "InsertEnter" },
        config = require("editor.cool"),
    }
}
