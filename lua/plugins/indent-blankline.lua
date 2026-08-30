local gh = require('utils').gh
vim.pack.add {
  gh 'lukas-reineke/indent-blankline.nvim',
}

require('utils').on_file_types(
  '*',
  function()
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
  end
)
