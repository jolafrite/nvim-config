vim.loader.enable()

vim.g.have_nerd_font = true

-- options
vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.g.lazyvim_cmp = 'nvim-cmp'
vim.g.lazyvim_picker = 'snacks'
vim.g.lualine_info_extras = true

vim.g.autoformat = true

vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.g.root_spec = {
  'lsp',
  {
    '.git',
    'lua',
    '.obsidian',
    'package.json',
    'Makefile',
    'go.mod',
    'cargo.toml',
    'pyproject.toml',
    'src',
  },
  'cwd',
}

vim.opt.backup = true
vim.opt.backupdir = { vim.fn.stdpath 'state' .. '/backup' }
vim.opt.cmdheight = 0
vim.opt.mousescroll = 'ver:1,hor:4'
vim.opt.title = true

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- Enable spell checking
vim.opt.spell = true

-- Backspacing and indentation when wrapping
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.breakindent = true

vim.opt.smoothscroll = true

vim.opt.conceallevel = 2

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.cmd [[au BufNewFile,BufRead *.astro setf astro]]
vim.cmd [[au BufNewFile,BufRead Podfile setf ruby]]

-- Make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

vim.g.lazyvim_python_lsp = 'basedpyright'
vim.g.lazyvim_python_ruff = 'ruff'

-- Deferred to Phase 2: the terminal integration global is not available under vim.pack.
-- if vim.fn.has("win32") == 1 then
--   terminal.setup("pwsh")
-- end

vim.g.deprecation_warnings = true
vim.env.FZF_DEFAULT_OPTS = ''
vim.g.ai_cmp = false
vim.g.lazyvim_blink_main = false

-- vim: ts=2 sts=2 sw=2 et
