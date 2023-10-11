-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/JoosepAlviste/nvim-ts-context-commentstring
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  event = { 'BufReadPost' },
  config = function()
    require('plugins/configs/nvim_ts_context_commentstring')
  end,
}

