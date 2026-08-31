local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'monkoose/neocodeium',
  lazy = false,
  config = function()
    local neocodeium = require 'neocodeium'
    neocodeium.setup()
    vim.keymap.set('i', '<A-f>', neocodeium.accept)
  end,
}

-- vim: ts=2 sts=2 sw=2 et
