require("core.options")
require("core.keymaps")
require("core.lazy")
require("core.colorscheme")

vim.opt.guicursor = ""

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[autocmd FileType yaml setlocal indentexpr=]])
vim.cmd([[autocmd FileType yml setlocal indentexpr=]])

vim.opt.termguicolors = true

-- https://github.com/kevinfengcs88/nvim
-- https://github.com/imbacraft/dusk.nvim
