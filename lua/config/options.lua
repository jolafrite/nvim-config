vim.loader.enable()

vim.g.have_nerd_font = true

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.o.number = true
vim.o.relativenumber = true

vim.g.autoformat = true

vim.opt.fileencoding = "utf-8"

vim.g.root_spec = {
  "lsp",
  {
    ".git",
    "lua",
    ".obsidian",
    "package.json",
    "Makefile",
    "go.mod",
    "Cargo.toml",
    "pyproject.toml",
    "src",
  },
  "cwd",
}

vim.opt.backup = true
vim.opt.backupdir = { vim.fn.stdpath("state") .. "/backup" }
vim.opt.cmdheight = 0
vim.opt.mousescroll = "ver:1,hor:4"
vim.opt.title = true

vim.opt.spell = true

vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.breakindent = true

vim.opt.smoothscroll = true

vim.opt.conceallevel = 2

vim.o.swapfile = false

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.o.cursorline = true

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

if vim.fn.has("win32") == 1 then
  require("utils").terminal.setup("pwsh")
end

vim.g.deprecation_warnings = true
vim.env.FZF_DEFAULT_OPTS = ""

vim.opt.clipboard = "unnamedplus"
