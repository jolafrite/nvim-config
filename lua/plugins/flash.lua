local gh = require('utils').gh

Manager.add {
  [1] = gh 'folke/flash.nvim',
  filetype = '*',
  config = function() require('flash').setup {} end,
}

-- stylua: ignore
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end,
  { desc = 'Flash' })
vim.keymap.set({ 'n', 'o', 'x' }, 'S', function() require('flash').treesitter() end, { desc = 'Flash Treesitter' })
vim.keymap.set('o', 'r', function() require('flash').remote() end, { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' }, 'R', function() require('flash').treesitter_search() end, { desc = 'Treesitter Search' })
vim.keymap.set('c', '<c-s>', function() require('flash').toggle() end, { desc = 'Toggle Flash Search' })
vim.keymap.set(
  { 'n', 'o', 'x' },
  '<c-space>',
  function()
    require('flash').treesitter {
      actions = {
        ['<c-space>'] = 'next',
        ['<BS>'] = 'prev',
      },
    }
  end,
  { desc = 'Treesitter Incremental Selection' }
)

-- vim: ts=2 sts=2 sw=2 et
