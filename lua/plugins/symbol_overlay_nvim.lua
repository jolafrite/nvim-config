return {
  'hek14/symbol-overlay.nvim',
  event = 'VeryLazy',
  config = function()
    require('plugins/configs/symbol_overlay_nvim')
  end,
}
