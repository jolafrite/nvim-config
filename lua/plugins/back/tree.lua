return {
    ["nvim-tree/nvim-tree.lua"] = {
        lazy = true,
        cmd = {
            "NvimTreeToggle",
            "NvimTreeOpen",
            "NvimTreeFindFile",
            "NvimTreeFindFileToggle",
            "NvimTreeRefresh",
        },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = require("tool.tree"),
    }
}
