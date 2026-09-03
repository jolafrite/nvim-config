local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'chrisgrieser/nvim-various-textobjs',
  lazy = true,
  config = function()
    require('various-textobjs').setup {
      keymaps = {
        useDefaults = true,
      },
    }
  end,
}
