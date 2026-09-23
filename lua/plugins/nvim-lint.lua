local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'mfussenegger/nvim-lint',
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}