require 'utils'
_G.Utils = require 'utils'
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.pack'

-- Plugin loading: Manager.add() specs register in the plugin files below;
-- Manager.load_all() does the actual startup/event/filetype split loading.
require 'manager'
require 'plugins'

-- vim.pack update engine and its float UI (:PackFloat). Loaded explicitly
-- rather than through Manager.add() — they own state, not a plugin spec.
require 'plugins.pack'
require 'plugins.pack_float'

-- Lazy filetype plugins (batch 2 of the Manager migration is deferred; the
-- language plugin files still load via this loop until converted).
require 'plugins.lang'

pcall(vim.cmd.colorscheme, 'shades-of-purple')

-- vim: ts=2 sts=2 sw=2 et
