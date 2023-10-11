-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/NvChad/nvim-colorizer.lua
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'NvChad/nvim-colorizer.lua',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/nvim_colorizer_lua')
  end,
}

