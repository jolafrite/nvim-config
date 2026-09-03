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
