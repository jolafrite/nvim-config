return {
  'petertriho/nvim-scrollbar',
  event = 'VimEnter',
  dependencies = { { 'kevinhwang91/nvim-hlslens' } },
  config = function()
    require('plugins/configs/nvim_scrollbar')
  end,
}
