-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/nvim-lualine/lualine.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  config = function()
    require('plugins/configs/lualine_nvim')
  end,
}
