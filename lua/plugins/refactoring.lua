local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'lewis6991/async.nvim',
  dependencies = {
    gh 'theprimeagen/refactoring.nvim',
  },
  event = 'LSPAttach',
  config = function() require('refactoring').setup {} end,
}
