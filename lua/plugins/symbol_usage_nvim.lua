-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/Wansmer/symbol-usage.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "Wansmer/symbol-usage.nvim",
  config = function()
    require('symbol-usage').setup()
  end
}

