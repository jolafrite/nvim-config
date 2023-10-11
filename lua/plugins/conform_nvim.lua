-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/stevearc/conform.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "stevearc/conform.nvim",
  event = "VimEnter",
  config = function()
    require("plugins/configs/conform_nvim")
  end,
}
