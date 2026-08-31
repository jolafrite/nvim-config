local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'j-hui/fidget.nvim',
  event = 'LspAttach',
  config = function() require('fidget').setup {} end,
}

-- vim: ts=2 sts=2 sw=2 et
