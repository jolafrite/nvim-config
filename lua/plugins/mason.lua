local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'mason-org/mason.nvim',
  dependencies = {
    gh 'mason-org/mason-registry',
  },
  lazy = false,
  config = function()
    require('mason').setup {
      pip = {
        use_uv = true,
      },
    }

    local mr = require 'mason-registry'
    mr:on('package:install:success', function()
      vim.defer_fn(function() vim.cmd [[do FileType]] end, 100)
    end)
  end,
}

-- vim: ts=2 sts=2 sw=2 et
