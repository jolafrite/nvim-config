local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'MeanderingProgrammer/render-markdown.nvim',
  filetype = 'markdown',
  config = function() require('render-markdown').setup {} end,
}
