-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/vuki656/package-info.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'vuki656/package-info.nvim',
  event = 'VeryLazy',
  ft = 'json',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('plugins/configs/package_info_nvim')
  end,
}

