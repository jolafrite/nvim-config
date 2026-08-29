local gh = require('utils').gh

vim.pack.add {
  gh 'mistweaverco/kulala.nvim',
}

local function node_path_resolver() return vim.fn.trim(vim.fn.system 'which node') end

require('kulala').setup {
  global_keymaps = true,
  global_keymaps_prefix = '<leader>R',
  kulala_keymaps_prefix = '',
  scripts = {
    node_path_resolver = node_path_resolver,
  },
}
