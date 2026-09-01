local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'lukas-reineke/indent-blankline.nvim',
  lazy = false,
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

-- vim: ts=2 sts=2 sw=2 et
