-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/mfussenegger/nvim-lint
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "mfussenegger/nvim-lint",
	event = "VimEnter",
	config = function()
		require("plugins/configs/nvim_lint")
	end,
}
