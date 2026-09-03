local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'haringsrob/nvim_context_vt',
  lazy = true,
  config = function()
    require('nvim_context_vt').setup {
      disable_ft = { 'rust', 'rs' },
      disable_virtual_lines = true,
      min_rows = 8,
    }
  end,
}
