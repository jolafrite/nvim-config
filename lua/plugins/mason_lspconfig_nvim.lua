return {
  'williamboman/mason-lspconfig.nvim',
  event = 'BufReadPre',
  dependencies = {
    {
      'folke/neoconf.nvim',
      cwd = { 'Neoconf' },
      config = function()
        require('plugins/configs/neoconf_nvim')
      end,
    },
    {
      'folke/neodev.nvim',
      config = function()
        require('plugins/configs/neodev_nvim')
      end,
    },
    { 'weilbith/nvim-lsp-smag', after = 'nvim-lspconfig' },
  },
  config = function()
    require('plugins/configs/mason_lspconfig_nvim')
  end,
}
