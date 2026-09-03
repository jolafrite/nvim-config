local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'MagicDuck/grug-far.nvim',
  filetype = '*',
  config = function()
    require('grug-far').setup {
      headerMaxWidth = 80,
    }
  end,
}

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
