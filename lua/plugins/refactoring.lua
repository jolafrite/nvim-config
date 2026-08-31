local gh = require('utils').gh

require('utils').on_lsp_attach(function()
  vim.pack.add {
    gh 'lewis6991/async.nvim',
    gh 'theprimeagen/refactoring.nvim',
  }

  require('refactoring').setup {}
end)
