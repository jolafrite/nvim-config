-- Defines core plugins that are used by other plugins
local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'MunifTanjim/nui.nvim',
  [2] = gh 'nvim-lua/plenary.nvim',
  lazy = false,
}
