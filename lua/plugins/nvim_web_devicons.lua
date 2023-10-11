-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/kyazdani42/nvim-web-devicons
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "kyazdani42/nvim-web-devicons",
  enabled = function()
	return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
  end,
}
