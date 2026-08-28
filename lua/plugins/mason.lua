local gh = require('utils').gh

vim.pack.add {
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-registry',
}

require('mason').setup {
  pip = {
    use_uv = true,
  },
}

local mr = require 'mason-registry'
mr:on('package:install:success', function()
  vim.defer_fn(function() vim.cmd [[do FileType]] end, 100)
end)
