local gh = require('utils').gh

-- Cursor-cell highlighting. Needs a real buffer, so load on first BufReadPost
-- rather than at startup.
require('utils').on_buf_read(function()
  vim.pack.add {
    gh 'RRethy/vim-illuminate.git',
  }

  require('illuminate').configure {
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    delay = 100,
    filetypes_denylist = {
      'dirbuf',
      'dirvish',
      'fugitive',
    },
    under_cursor = true,
    should_enable = function(bufnr) return true end,
  }
end)
