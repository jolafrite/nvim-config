local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Doom emacs keymap for find file
keymap('n', '<leader><leader>', '<cmd>Telescope find_files hidden=true no_ignore=true<cr>', opts)

-- Better window navigation
keymap('n', '<leader>w<Left>', '<C-w>h', opts)
keymap('n', '<leader>w<Up>', '<C-w>j', opts)
keymap('n', '<leader>w<Down>', '<C-w>k', opts)
keymap('n', '<leader>w<Right>', '<C-w>l', opts)
keymap('n', '<leader>ww', '<C-w>w', opts)
