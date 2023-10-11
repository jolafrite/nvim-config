-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/hinell/lsp-timeout.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'hinell/lsp-timeout.nvim',
  event = 'VeryLazy',
  dependences = {
    'neovim/nvim-lspconfig',
  },
  config = function()
    require('plugins/configs/lsp_timeout_nvim')
  end,
}
