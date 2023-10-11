vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<C-e>", "<Cmd>Neotree toggle<CR>")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = true,
    cmd = {
      "NvimTreeToggle",
      "NvimTreeOpen",
      "NvimTreeFindFile",
      "NvimTreeFindFileToggle",
      "NvimTreeRefresh",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim'
    },
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require 'window-picker'.setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', "quickfix" },
            },
          },
        })
      end,
    },
    config = function()
      require("neo-tree").setup {
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            visible = true
          }
        },
        follow_current_file = {
          enabled = true
        }
      }
    end
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
