return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    build = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.api.nvim_command("TSUpdate")
      end
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "mrjones2014/nvim-ts-rainbow" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "mfussenegger/nvim-treehopper" },
      { "andymass/vim-matchup" },
      -- {
      --   "windwp/nvim-ts-autotag",
      --   config = function()
      --     require("nvim-ts-autotag").setup({
      --       filetypes = {
      --         "html",
      --         "javascript",
      --         "javascriptreact",
      --         "typescriptreact",
      --         "vue",
      --         "xml",
      --       },
      --     })
      --   end
      -- },
      {
        "NvChad/nvim-colorizer.lua",
        config = function()

        end
      },
      {
        "abecodes/tabout.nvim",
        config = function()
          require("tabout").setup({
            tabkey = "<Tab>",         -- key to trigger tabout, set to an empty string to disable
            backwards_tabkey = "",    -- key to trigger backwards tabout, set to an empty string to disable
            act_as_tab = true,        -- shift content if tab out is not possible
            act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
            enable_backwards = true,
            completion = true,        -- if the tabkey is used in a completion pum
            tabouts = {
              { open = "'", close = "'" },
              { open = '"', close = '"' },
              { open = "`", close = "`" },
              { open = "(", close = ")" },
              { open = "[", close = "]" },
              { open = "{", close = "}" },
            },
            ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
            exclude = {},            -- tabout will ignore these filetypes
          })
        end
      },
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc',
          'vim' },
        ignore_install = {},

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,
        sync_install = false,

        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end
  }
}
