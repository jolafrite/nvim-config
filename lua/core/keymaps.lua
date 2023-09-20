local opts = { noremap = true, silent = true }
local keymap = vim.keymap
local global = vim.g

global.mapleader = ' '
global.maplocalleader = ' '

-- make CTRL + C behave exactly the same as ESC
keymap.set('i', '<C-c>', '<ESC>', opts)

-- toggle nvim-tree
keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', opts)
--
-- the greatest remap ever (Primeagen)
keymap.set('v', '<leader>p', '"_dP', opts)
