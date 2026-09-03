local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'aznhe21/actions-preview.nvim',
  event = 'LSPAttach',
  config = function()
    require('actions-preview').setup {
      backend = { 'snacks' },
      snacks = {
        layout = { preset = 'dropdown' },
      },
    }
  end,
}

vim.keymap.set({ 'v', 'n' }, '<leader>ca', function() require('actions-preview').code_actions() end, { desc = 'Preview Code Actions' })
