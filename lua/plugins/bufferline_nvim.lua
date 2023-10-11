-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/akinsho/bufferline.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'akinsho/bufferline.nvim',
  event = 'VimEnter',
  enabled = function()
    return not vim.g.vscode
  end,
  config = function()
    require('plugins/configs/bufferline_nvim')
  end,
}

