local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'j-hui/fidget.nvim',
  event = 'LspAttach',
  config = function() require('fidget').setup {} end,
}
