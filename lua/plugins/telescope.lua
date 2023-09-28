return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        event = 'VimEnter',
        cmd = "Telescope",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-lua/popup.nvim" },
            {
                "ahmedkhalf/project.nvim",
                event = "CursorHold",
                config = function()

                end
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                dependencies = {
                    { "kkharji/sqlite.lua" },
                }
            },
            { "jvgrootveld/telescope-zoxide" },
            { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        },
        config = function()
            local status_ok, telescope = pcall(require, 'telescope')

            if not status_ok then
                return
            end

            telescope.setup()
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<C-p>', builtin.find_files, {})
            vim.keymap.set('n', '<leader>r', builtin.oldfiles, {})
            vim.keymap.set('n', '<leader>gr', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fj', builtin.help_tags, {})
        end
    }
}
