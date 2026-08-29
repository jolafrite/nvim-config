local gh = require('utils').gh

-- Search/replace surface. Loaded on first BufReadPost so it is not in the
-- startup path; the keymap still resolves at press time.
require('utils').on_file_types('*', function()
  vim.pack.add {
    gh 'MagicDuck/grug-far.nvim',
  }

  require('grug-far').setup {
    headerMaxWidth = 80,
  }
end)

vim.keymap.set({ 'n', 'x' }, '<leader>sr', function()
  local grug = require 'grug-far'
  local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
  grug.open {
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
    },
  }
end, { desc = 'Search and Replace' })
