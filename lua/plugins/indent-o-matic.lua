local gh = require('utils').gh

vim.pack.add {
  gh 'Darazaki/indent-o-matic',
}

require('utils').on_file_types('*', function() require('indent-o-matic').setup { skip_multiline = true } end)
