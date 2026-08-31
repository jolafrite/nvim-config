local gh = require('utils').gh

vim.pack.add {
  gh 'windwp/nvim-autopairs',
}

require('utils').on_file_types('*', function() require('nvim-autopairs').setup { check_ts = true } end)
