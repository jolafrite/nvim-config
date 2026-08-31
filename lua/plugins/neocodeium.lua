local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'monkoose/neocodeium',
  lazy = false,
  config = function()
    -- Without setup() the options table stays empty and neocodeium's logger
    -- crashes ("attempt to compare nil with number" in log.lua).
    require('neocodeium').setup {}
  end,
}

-- vim: ts=2 sts=2 sw=2 et
