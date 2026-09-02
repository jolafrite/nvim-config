local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'windwp/nvim-autopairs',
  filetype = '*',
  config = function() require('nvim-autopairs').setup { check_ts = true } end,
}

