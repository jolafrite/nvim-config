local gh = require('utils').gh

-- Cursor-cell highlighting. Needs a real buffer, so load on first BufReadPost
-- rather than at startup.
PackageManager.add {
  [1] = gh 'RRethy/vim-illuminate.git',
  event = 'BufReadPost',
  config = function()
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
    }
  end,
}
