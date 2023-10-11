-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/AckslD/nvim-neoclip.lua
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'AckslD/nvim-neoclip.lua',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/nvim_neoclip_lua')
  end,
}

