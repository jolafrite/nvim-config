local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'folke/which-key.nvim',
  lazy = false,
  config = function()
    local wk = require 'which-key'

    local opts = {
      preset = 'helix',
      defaults = {},
      spec = {
        {
          mode = { 'n', 'x' },
          { '<leader><tab>', group = 'tabs' },
          { '<leader>c', group = 'code' },
          { '<leader>d', group = 'debug' },
          { '<leader>dp', group = 'profiler' },
          { '<leader>f', group = 'file/find' },
          { '<leader>g', group = 'git' },
          { '<leader>gh', group = 'hunks' },
          { '<leader>q', group = 'quit/session' },
          { '<leader>s', group = 'search' },
          { '<leader>u', group = 'ui' },
          { '<leader>x', group = 'diagnostics/quickfix' },
          { '[', group = 'prev' },
          { ']', group = 'next' },
          { 'g', group = 'goto' },
          { 'gs', group = 'surround' },
          { 'z', group = 'fold' },
          {
            '<leader>b',
            group = 'buffer',
            expand = function() return require('which-key.extras').expand.buf() end,
          },
          {
            '<leader>w',
            group = 'windows',
            proxy = '<c-w>',
            expand = function() return require('which-key.extras').expand.win() end,
          },
          { 'gx', desc = 'Open with system app' },
        },
      },
    }

    wk.setup(opts)

    if not vim.tbl_isempty(opts.defaults) then
      vim.notify 'which-key: opts.defaults is deprecated. Please use opts.spec instead.'
      wk.register(opts.defaults)
    end

    wk.add({
      {
        '<leader>?',
        function() wk.show { global = false } end,
        desc = 'Buffer Keymaps (which-key)',
      },
      {
        '<c-w><space>',
        function() wk.show { keys = '<c-w>', loop = true } end,
        desc = 'Window Hydra Mode (which-key)',
      },
    }, { notify = false })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
