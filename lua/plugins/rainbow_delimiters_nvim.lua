-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/HiPhish/rainbow-delimiters.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'HiPhish/rainbow-delimiters.nvim',
  event = 'BufReadPost',
  config = function()
    require('plugins/configs/rainbow_delimiters_nvim')
  end,
}

