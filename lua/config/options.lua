vim.loader.enable()

vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cmdheight = 0
vim.opt.conceallevel = 2
vim.opt.fileencoding = 'utf-8'
vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldtext = '' -- Use treesitter for fold text
vim.opt.mousescroll = 'ver:1,hor:4'
vim.opt.smoothscroll = true
vim.opt.spell = true
vim.opt.title = true

-- Neovim 0.13 additions
vim.opt.scrolloffpad = 2          -- allow vertically centering cursor at EOF
vim.opt.messagesopt = { pager = '<CR>', timeout = 3000 }  -- ui2 message pager + timeout
vim.opt.winpinned = false         -- allow windows to close normally
vim.opt.shortmess:append('u')     -- silence undo/redo messages

vim.g.autoformat = true
vim.g.deprecation_warnings = true
vim.g.have_nerd_font = true
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.mapleader = ','
vim.g.maplocalleader = ','
vim.g.root_spec = {
  'lsp',
  {
    '.git',
    'lua',
    '.obsidian',
    'package.json',
    'Makefile',
    'go.mod',
    'Cargo.toml',
    'pyproject.toml',
    'src',
  },
  'cwd',
}

vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.swapfile = false

vim.cmd [[au BufNewFile,BufRead *.astro setf astro]]
vim.cmd [[au BufNewFile,BufRead Podfile setf ruby]]

local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

if vim.fn.has 'win32' == 1 then require('utils').terminal.setup 'pwsh' end

vim.env.FZF_DEFAULT_OPTS = ''
