-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/folke/todo-comments.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/todo_comments_nvim')
  end,
}

