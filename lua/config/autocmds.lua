-- check if need to reload the file when it changed
local autoreload = vim.api.nvim_create_augroup('autoreload', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = autoreload,
  callback = function()
    if vim.o.buftype ~= 'nofile' then vim.cmd.checktime() end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json', 'jsonc', 'markdown' },
  callback = function() vim.opt.conceallevel = 0 end,
})

-- Strip the 'cro' auto-comment flags per-filetype (ftplugins re-set them, so
-- this has to run after FileType, not once at startup).
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    vim.bo[args.buf].formatoptions = vim.bo[args.buf].formatoptions:gsub('[cro]', '')
  end,
})

-- Spell check prose buffers only; code buffers stay spell-free.
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'gitcommit', 'tex', 'plaintex', 'rst', 'help' },
  callback = function() vim.opt_local.spell = true end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- Toggle between relative/absolute line numbers
local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  pattern = '*',
  group = numbertoggle,
  callback = function()
    if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then vim.opt.relativenumber = true end
  end,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  pattern = '*',
  group = numbertoggle,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      vim.cmd.redraw()
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
