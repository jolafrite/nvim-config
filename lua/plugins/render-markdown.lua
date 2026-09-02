local gh = require('utils').gh



PackageManager.add {
  [1] = gh 'MeanderingProgrammer/render-markdown.nvim',
  filetype = 'markdown',
  config = function()
    require('render-markdown').setup {
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    }
  end,
}

