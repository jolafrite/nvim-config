local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'Darazaki/indent-o-matic',
  lazy = false,
  config = function()
    require('utils').on_file_types('*', function() require('indent-o-matic').setup { skip_multiline = true } end)
  end,
}
