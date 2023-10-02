return {
  {
    "roobert/activate.nvim",
    lazy = false,
    keys = {
        {
            "<leader>P",
            '<CMD>lua require("activate").list_plugins()<CR>',
            desc = "Plugins",
        },
    }
  }
}

