-- Lean language support (lean.nvim).
--
-- lean.nvim manages the leanls language server through its own machinery,
-- so no `vim.lsp.config`/`vim.lsp.enable` is needed here.
local gh = require('utils').gh

vim.pack.add {
  gh 'Julian/lean.nvim',
  gh 'nvim-lua/plenary.nvim',
}

local lean_opts = {
  -- Enable the Lean language server(s) with the options below.
  lsp = {
    init_options = {
      -- Time (in milliseconds) which must pass since latest edit until
      -- elaboration begins. Lower values make editing feel faster at the
      -- cost of higher CPU usage (lean.nvim changes the Lean default).
      editDelay = 0,
      -- Whether to signal that widgets are supported.
      hasWidgets = true,
    },
  },
  ft = {
    -- Files matched by these patterns are protected (marked `nomodifiable`)
    -- by default when they belong to the stdlib or a dependency (`_target`).
    nomodifiable = {},
  },
  -- Abbreviation support (`\wknight` -> ♘, etc.).
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

-- vim: ts=2 sts=2 sw=2 et
