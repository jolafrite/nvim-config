-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/williamboman/mason.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "williamboman/mason.nvim",
	event = { "BufReadPre", "VimEnter" },
	build = ":MasonUpdate",
	config = function()
		require("plugins/configs/mason_nvim")
	end,
}
