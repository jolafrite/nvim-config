local set = vim.opt

vim.g.lazygit_floating_window_winblend = 0

set.mouse = "a"
set.clipboard = "unnamedplus"
set.swapfile = false

set.autoindent = true
set.smartindent = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2

set.number = true
set.relativenumber = true
set.backspace = '2'
set.showcmd = true
set.laststatus = 2
set.autowrite = true
set.autoread = true
set.cursorline = true
set.cursorlineopt = 'number'
set.relativenumber = true
set.wrap = false
set.ignorecase = true
set.smartcase = true
set.termguicolors = true
set.expandtab = true
set.shiftround = true
set.formatoptions:remove({ 'c', 'r', 'o' })
set.mousemoveevent = true
