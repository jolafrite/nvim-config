-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/nguyenvukhang/nvim-toggler
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "nguyenvukhang/nvim-toggler",
  event = "BufReadPost",
  config = function()
    require("nvim-toggler").setup {}
  end,
}
