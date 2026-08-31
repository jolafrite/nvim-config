local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'nvim-neotest/neotest',
  dependencies = {
    gh 'nvim-neotest/nvim-nio',
  },
  lazy = false,
}

-- vim: ts=2 sts=2 sw=2 et
