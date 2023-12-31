return {
  ['hrsh7th/nvim-cmp'] = {
    lazy = true,
    event = 'InsertEnter',
    config = require('completion.cmp'),
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'FelipeLema/cmp-async-path' },
      { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-omni' },
      { 'yutkat/cmp-mocword' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'lukas-reineke/cmp-under-comparator' },
      { 'andersevenrud/cmp-tmux' },
      { 'f3fora/cmp-spell' },
      { 'kdheepak/cmp-latex-symbols' },
      { 'ray-x/cmp-treesitter' },
      {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
        build = 'make install_jsregexp',
        config = require('completion.luasnip'),
      },
      { 'onsails/lspkind.nvim' },
      {
        'windwp/nvim-autopairs',
        config = require('completion.autopairs'),
      },
      { 'JMarkin/cmp-diag-codes' },
      { 'petertriho/cmp-git' },
      { 'hrsh7th/cmp-cmdline' },
      {
        'uga-rosa/cmp-dictionary',
        config = require('completion.dictionary'),
      },
      { 'lukas-reineke/cmp-rg' },
      { 'lukas-reineke/cmp-under-comparator' },
    },
  },
}
