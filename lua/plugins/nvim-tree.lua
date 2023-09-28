--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim'
    },
    opts = {
      close_if_last_window = true,
      window = {
        position = "left",
        width = 40,

      }
    }
  },
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim"
    },
    config = function()
      require("lsp-file-operations").setup()
    end
  }
}
