return {
  ['stevearc/dressing.nvim'] = {
    lazy = true,
    event = 'VimEnter',
    config = require('ui.dressing'),
  },
}
