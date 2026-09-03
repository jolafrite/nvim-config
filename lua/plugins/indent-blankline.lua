local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'lukas-reineke/indent-blankline.nvim',
  filetype = '*',
  config = function()
    require('ibl').setup {
      indent = {
        char = '▎',
        tab_char = '▎',
      },
      scope = {
        include = {
          node_type = {
            all = {
              'return_statement',
              'table_constructor',
            },
          },
        },
      },
    }
  end,
}
