-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/XXiaoA/ns-textobject.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'XXiaoA/ns-textobject.nvim',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/ns_textobject_nvim')
  end,
}

