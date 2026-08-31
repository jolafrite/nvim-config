require 'utils'
_G.Utils = require 'utils'
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

-- Plugin loading: every plugin file in lua/plugins/*.lua registers a spec via
-- PackageManager.add(). PackageManager.load_all() does the actual startup/event/filetype
-- split loading.
require 'utils.package_manager'

-- The vim.pack update engine (:PackCheck) and float UI (:PackFloat) are pulled
-- in by utils.package_manager itself — they own state, not a plugin spec.

-- Phase 1: register the filetype-triggered language plugin specs BEFORE
-- load_all() runs, so their triggers are wired.
require('plugins.lang').load_specs()

require 'plugins'

-- Phase 2: the config-only language files (json, lua, python, ruby, toml,
-- typescript, typst, yaml, markdown) register vim.lsp.config servers and
-- call require('conform')/require('lint') at top level — those dependencies
-- are loaded by load_all() above, so this runs after.
require('plugins.lang').load_configs()

pcall(vim.cmd.colorscheme, 'shades-of-purple')

-- vim: ts=2 sts=2 sw=2 et
