
local autoreload = vim.api.nvim_create_augroup('autoreload', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = autoreload,
  callback = function()
    if vim.bo.buftype ~= 'nofile' then vim.cmd.checktime() end
  end,
})

local filetype_settings = vim.api.nvim_create_augroup('filetype_settings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = filetype_settings,
  pattern = { 'json', 'jsonc', 'markdown' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = filetype_settings,
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

vim.api.nvim_create_autocmd({ 'TextYankPost', 'TextPutPost' }, {
  group = vim.api.nvim_create_augroup('hl_actions', { clear = true }),
  callback = function()
    vim.hl.hl_op({ higroup = 'IncSearch', timeout = 150 })
  end,
})

local cursorline_toggle = vim.api.nvim_create_augroup('cursorline_toggle', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  group = cursorline_toggle,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  group = cursorline_toggle,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number and vim.api.nvim_get_mode().mode ~= 'i' then
      vim.wo.relativenumber = true
    end
  end,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})
