-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/windwp/nvim-autopairs
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
	require("plugins/configs/nvim_autopairs")
  end
}
