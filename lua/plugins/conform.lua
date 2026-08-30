local gh = require('utils').gh

vim.pack.add {
  gh 'stevearc/conform.nvim',
}

local conform = require 'conform'

local M = {}

M.format_on_save = function(bufnr)
  if vim.g.conform_format_on_save == false then return false end
  if vim.b[bufnr or 0].conform_formatting == true then return false end
  return true
end

M.toggle = function() vim.g.conform_format_on_save = not M.is_on() end

M.is_on = function() return vim.g.conform_format_on_save ~= false end

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Format on save (toggleable via <leader>cF)',
  pattern = '*',
  group = vim.api.nvim_create_augroup('ConformOnSave', { clear = true }),
  callback = function(args)
    if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= '' then return end
    if not M.format_on_save(args.buf) then return end
    conform.format { buf = args.buf, async = false, timeout_ms = 1000 }
  end,
})
vim.keymap.set({ 'n', 'x' }, '<leader>cf', function() require('conform').format { force = true } end, { desc = 'Format' })

vim.keymap.set('n', '<leader>cF', M.toggle, { desc = 'Toggle format on save' })

return M
