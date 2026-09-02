-- Plugin loading happens in two passes around PackageManager.load_all():
--
--   1. Files directly in plugins/: PackageManager.add specs and config for
--      startup-loaded plugins.
--   2. After load_all() has loaded the startup plugins and armed the
--      filetype/event triggers: the whole tree recursively. Nested files
--      (e.g. plugins/lang/*) configure conform/lint/treesitter/LSP, which
--      must run after those plugins exist; specs they register are handled
--      by PackageManager at any time. Files already loaded by pass 1 are
--      skipped via package.loaded.

local loader = require 'utils.plugins_loader'

loader.load 'plugins'
PackageManager.load_all()
loader.load('plugins', { recursive = true })
