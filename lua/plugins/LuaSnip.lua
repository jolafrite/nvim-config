-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/L3MON4D3/LuaSnip
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'L3MON4D3/LuaSnip',
  event = 'VimEnter',
  config = function()
    require('plugins/configs/LuaSnip')
  end,
}
