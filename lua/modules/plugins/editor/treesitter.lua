return {
  ["nvim-treesitter/nvim-treesitter"] = {
    lazy = true,
    build = function()
        if #vim.api.nvim_list_uis() ~= 0 then
            vim.api.nvim_command("TSUpdate")
        end
    end,
    event = { "CursorHold", "CursorHoldI" },
    config = require("editor.treesitter"),
    dependencies = {
        { "nvim-treesitter/nvim-treesitter-textobjects" },
        { "mrjones2014/nvim-ts-rainbow" },
        { "JoosepAlviste/nvim-ts-context-commentstring" },
        { "mfussenegger/nvim-treehopper" },
        { "andymass/vim-matchup" },
        {
            "windwp/nvim-ts-autotag",
            config = require("editor.autotag"),
        },
        {
            "NvChad/nvim-colorizer.lua",
            config = require("editor.colorizer"),
        },
        {
            "abecodes/tabout.nvim",
            config = require("editor.tabout"),
        },
    },
  }
}
