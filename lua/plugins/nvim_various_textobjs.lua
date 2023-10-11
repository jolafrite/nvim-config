-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/chrisgrieser/nvim-various-textobjs
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'chrisgrieser/nvim-various-textobjs',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/nvim_various_textobjs')
  end,
}
