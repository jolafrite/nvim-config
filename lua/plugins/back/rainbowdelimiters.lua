return {
    ["HiPhish/rainbow-delimiters.nvim"] = {
        lazy = true,
        event = "BufReadPost",
		config = require('editor.rainbowdelimiters')
    }
}
