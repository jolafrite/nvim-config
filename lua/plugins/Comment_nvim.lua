-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/numToStr/Comment.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/Comment_nvim')
  end,
}

