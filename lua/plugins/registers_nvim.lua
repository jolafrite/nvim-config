-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/tversteeg/registers.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  'tversteeg/registers.nvim',
  enable = function()
    return vim.fn.has('clipboard') == 1
  end,
  config = function()
    require('plugins/configs/registers_nvim')
  end,
}

