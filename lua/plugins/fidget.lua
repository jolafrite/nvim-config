local gh = require('utils').gh

require('utils').on_lsp_attach(function()
  vim.pack.add {
    gh 'j-hui/fidget.nvim',
  }

  require('fidget').setup {}
end)
