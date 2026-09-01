local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'windwp/nvim-autopairs',
  lazy = false,
  config = function() require('nvim-autopairs').setup { check_ts = true } end,
}

-- vim: ts=2 sts=2 sw=2 et
