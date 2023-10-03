return {
    ["neovim/nvim-lspconfig"] = {
        lazy = true,
        event = { "BufReadPost", "BufAdd", "BufNewFile" },
        config = require("completion.lspconfig"),
        dependencies = {
            { "ray-x/lsp_signature.nvim" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            {
                "glepnir/lspsaga.nvim",
                config = require("completion.lspsaga"),
            },
            {
                 "nvimtools/none-ls.nvim",
                 dependencies = {
                    "nvim-lua/plenary.nvim",
                    "jay-babu/mason-null-ls.nvim",
                 },
                 config = require("completion.nullls"),
            },
        },
    }
}
