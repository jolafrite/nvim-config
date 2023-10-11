-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/hrsh7th/nvim-cmp
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'hrsh7th/nvim-cmp',
  event = 'VimEnter',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-emoji' },
    { 'hrsh7th/cmp-calc' },
    { 'f3fora/cmp-spell' },
    { 'yutkat/cmp-mocword' },
    {
      'uga-rosa/cmp-dictionary',
      config = function()
        require('plugins/configs/cmp_dictionary')
      end,
    },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'ray-x/cmp-treesitter' },
    { 'lukas-reineke/cmp-rg' },
    { 'lukas-reineke/cmp-under-comparator' },
    {
      'onsails/lspkind-nvim',
      config = function()
        require('plugins/configs/lspkind_nvim')
      end,
    },
  },
  config = function()
    require('plugins/configs/nvim_cmp')
  end,
}
