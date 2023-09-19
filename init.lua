require("core.options")
require("core.keymaps")
require("core.lazy")
require("core.colorscheme")

vim.opt.guicursor = ""

vim.cmd([[autocmd FileType yaml setlocal indentexpr=]])
vim.cmd([[autocmd FileType yml setlocal indentexpr=]])
