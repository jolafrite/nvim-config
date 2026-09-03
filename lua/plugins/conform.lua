local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'stevearc/conform.nvim',
  lazy = false,
  config = function()
    local conform = require 'conform'

    local format_on_save = function(bufnr)
      if vim.g.conform_format_on_save == false then return false end
      if vim.b[bufnr or 0].conform_formatting == true then return false end
      return true
    end

    local toggle = function() vim.g.conform_format_on_save = not (vim.g.conform_format_on_save ~= false) end
    local is_on = function() return vim.g.conform_format_on_save ~= false end

    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Format on save (toggleable via <leader>cF)',
      pattern = '*',
      group = vim.api.nvim_create_augroup('ConformOnSave', { clear = true }),
      callback = function(args)
        if not vim.api.nvim_buf_is_valid(args.buf) or vim.bo[args.buf].buftype ~= '' then return end
        if not format_on_save(args.buf) then return end
        conform.format { buf = args.buf, async = false, timeout_ms = 1000 }
      end,
    })
    vim.keymap.set({ 'n', 'x' }, '<leader>cf', function() conform.format { force = true } end, { desc = 'Format' })
    vim.keymap.set('n', '<leader>cF', toggle, { desc = 'Toggle format on save' })
  end,
}
