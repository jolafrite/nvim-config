require 'utils'
_G.Utils = require 'utils'
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Plugin loading: every plugin file in lua/plugins/*.lua (and
-- lua/plugins/lang/*.lua, including config-only LSP specs) registers a spec via
-- PackageManager.add(). PackageManager.load_all() does the actual
-- startup/event/filetype split loading.
require 'utils.package_manager'

-- The vim.pack update engine (:PackCheck) and float UI (:PackFloat) are pulled
-- in by utils.package_manager itself — they own state, not a plugin spec.

-- Register the filetype-triggered language specs BEFORE load_all() runs,
-- so their triggers are wired.
require('plugins.lang').load_specs()

require 'plugins'

pcall(vim.cmd.colorscheme, 'shades-of-purple')

-- vim: ts=2 sts=2 sw=2 et
