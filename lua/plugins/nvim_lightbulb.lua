local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'kosayoda/nvim-lightbulb',
  event = 'LSPAttach',
  config = function()
    require('nvim-lightbulb').setup {
      autocmd = { enabled = true },
      sign = { enabled = true, text = '󰰀' },
      action_kinds = { 'quickfix', 'refactor' },
      ignore = {
        actions_without_kind = true,
      },
    }
  end,
}
