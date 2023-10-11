-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/nvim-treesitter/nvim-treesitter
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost' },
  build = ':TSUpdateSync',
  dependencies = {
    { 'JoosepAlviste/nvim-ts-context-commentstring' },
    { 'nvim-treesitter/nvim-treesitter-refactor' },
    { 'nvim-treesitter/nvim-tree-docs' },
    { 'yioneko/nvim-yati' },
    { 'andymass/vim-matchup' },
  },
  config = function()
    require('plugins/configs/nvim_treesitter')
  end,
}
