local gh = require('utils').gh

vim.pack.add {
  gh 'monkoose/neocodeium',
}

-- Without setup() the options table stays empty and neocodeium's logger
-- crashes ("attempt to compare nil with number" in log.lua).
require('neocodeium').setup {}
