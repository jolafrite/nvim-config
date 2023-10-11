-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/nvimdev/lspsaga.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'nvimdev/lspsaga.nvim',
  event = 'VimEnter',
  config = function()
    require('plugins/configs/lspsaga_nvim')
  end,
}

