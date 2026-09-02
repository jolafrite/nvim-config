local gh = require('utils').gh



PackageManager.add {
  [1] = gh 'artemave/workspace-diagnostics.nvim',
  event = 'LspAttach',
  config = function() require('workspace-diagnostics').setup {} end,
}

