-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/ziontee113/syntax-tree-surfer
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'ziontee113/syntax-tree-surfer',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/syntax_tree_surfer')
  end,
}

