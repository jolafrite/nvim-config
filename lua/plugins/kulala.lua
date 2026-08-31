local gh = require('utils').gh

local function node_path_resolver() return vim.fn.trim(vim.fn.system 'which node') end

PackageManager.add {
  [1] = gh 'mistweaverco/kulala.nvim',
  lazy = false,
  config = function()
    require('kulala').setup {
      global_keymaps = true,
      global_keymaps_prefix = '<leader>R',
      kulala_keymaps_prefix = '',
      scripts = {
        node_path_resolver = node_path_resolver,
      },
    }
  end,
}
