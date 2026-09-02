local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'chrisgrieser/nvim-chainsaw',
  lazy = true,
  config = function() require('chainsaw').setup() end,
}
