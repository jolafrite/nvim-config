local gh = require('utils').gh

PackageManager.add({
  [1] = gh 'Julian/lean.nvim',
  dependencies = {
    gh 'nvim-lua/plenary.nvim'
  },
  filetype = {'lean'},
  config = function()

local lean_opts = {
  lsp = {
    init_options = {
      
      editDelay = 0,
      hasWidgets = true,
    },
  },
  ft = {
    nomodifiable = {},
  },
  abbreviations = {
    enable = true,
    extra = { wknight = '♘' },
    leader = '\\',
  },
  mappings = true,
  infoview = {
    autoopen = true,
    width = 50,
    height = 20,
    horizontal_position = 'bottom',
    separate_tab = false,
    indicators = 'auto',
  },
  progress_bars = {
    enable = true,
    character = '│',
    priority = 10,
  },
  stderr = {
    enable = true,
    height = 5,
    on_lines = nil,
  },
}

require('utils').on_file_types({ 'lean' }, function()
  local ok, lean = pcall(require, 'lean')
  if ok then lean.setup(lean_opts) end
end)


  end,
})

