-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/haringsrob/nvim_context_vt
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'haringsrob/nvim_context_vt',
  event = 'BufReadPost',
  config = function()
    require('plugins/configs/nvim_context_vt')
  end,
}

