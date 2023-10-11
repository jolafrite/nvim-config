-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/nvim-zh/colorful-winsep.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'nvim-zh/colorful-winsep.nvim',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/colorful_winsep_nvim')
  end,
}

