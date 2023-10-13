local templates_dir = require('core.global').templates_dir
local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup('neovim_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  desc = 'Check for external changes to file and reload it',
  group = augroup('checktime'),
  command = 'checktime',
})

-- Highlight on yank
autocmd('TextYankPost', {
  desc = 'Highlight yanked objects',
  group = augroup('yank_highlight'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
autocmd({ 'VimResized' }, {
  desc = 'Resize splits if window got resized',
  group = augroup('resize_splits'),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- go to last loc when opening a buffer
autocmd('BufRead', {
  desc = 'Place the cursor on the last place you where in a file and center buffer around it',
  group = augroup('last_loc'),
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf

    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].neovim_last_loc then
      return
    end

    vim.b[buf].neovim_last_loc = true

    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)

    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
autocmd('FileType', {
  desc = 'Use q to close the window',
  group = augroup('close_with_q'),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
autocmd('FileType', {
  desc = 'wrap and check for spell in text filetypes',
  group = augroup('wrap_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Load skeleton file when a new empty file is created
autocmd('BufNewFile', {
  desc = 'Load skeleton file when a new empty file is created.',
  group = augroup('new_file_skeleton'),
  callback = function()
    local skeleton_name = templates_dir .. '/skeleton.' .. vim.fn.expand('<afile>:e')
    if vim.loop.fs_stat(skeleton_name) then
      vim.cmd.read({ args = { skeleton_name }, range = { 0, 0 } })
    end
  end,
})

-- Lint save on save
autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  desc = 'Lint save on save',
  group = augroup('lint'),
  callback = function()
    require('lint').try_lint()

    if vim.fn.filereadable('.vale.ini') > 0 then
      require('lint').try_lint({ 'vale' })
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  desc = 'Auto create dir when saving a file',
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})
