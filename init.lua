-- Nightly builds ship a package.path pointing at nonexistent build dirs.
-- Rebuild from what's on disk: config's lua/ + every RTP's lua/.
local function rebuild_package_path()
  local paths = {}
  local seen = {}
  for _, rtp in ipairs(vim.api.nvim_list_runtime_paths()) do
    local lua = rtp .. '/lua'
    if not seen[lua] and vim.fn.isdirectory(lua) == 1 then
      seen[lua] = true
      table.insert(paths, lua)
    end
  end
  local cfg = vim.fn.getcwd() .. '/lua'
  if not seen[cfg] then table.insert(paths, 1, cfg) end
  local parts = {}
  for _, d in ipairs(paths) do
    table.insert(parts, d .. '/?.lua')
    table.insert(parts, d .. '/?/init.lua')
  end
  package.path = table.concat(parts, ';') .. ';' .. package.path
  package.cpath = '' -- drop broken .so loaders
end

rebuild_package_path()

_G.Utils = require 'utils'

require 'config.options'
require 'config.keymaps'
require 'config.autocmds'

PluginsLoader.load 'plugins'
PackageManager.load()

-- Nightly build: vim.pack.add({load=true}) clones plugins asynchronously.
-- Plugins land on disk but active=false (not on RTP).
-- vim.pack.update() also returns immediately without activating.
-- Solution: explicitly activate each inactive plugin, then rebuild package.path.
local specs = vim.pack.get() or {}
for _, s in ipairs(specs) do
  if not s.active and s.path and vim.fn.isdirectory(s.path) == 1 then
    -- Activate by prepending to runtimepath
    vim.o.runtimepath = s.path .. ',' .. vim.o.runtimepath
  end
end

-- Rebuild package.path with all plugin lua/ dirs
rebuild_package_path()

vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('data') .. '/mason/bin'

vim.cmd.colorscheme 'shades-of-purple'
