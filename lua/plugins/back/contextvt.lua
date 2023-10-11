return {
    ["haringsrob/nvim_context_vt"] = {
        lazy = true,
        event = "BufReadPost",
		config = require("editor.contextvt")
    }
}
