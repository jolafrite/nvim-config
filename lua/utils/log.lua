--- Structured logging interface.
-- Wraps vim.log when available (0.13+), falls back to vim.notify with
-- numeric levels on older Neovim. Provides a single consistent API
-- across the entire config so log levels never drift.
--
-- Usage:
--   local log = require('utils.log')
--   log.warn('something happened')
--   log.error('something failed')
--   log.info('something notable')

local M = {}

-- Numeric vim.notify levels matching vim.log.levels
local _levels = (vim.log and vim.log.levels) or { error = 0, warn = 2, info = 1 }

--- Log at warn level
---@param msg string
M.warn = function(msg)
  if vim.log then vim.log.warn(msg) else vim.notify(msg, _levels.warn) end
end

--- Log at info level
---@param msg string
M.info = function(msg)
  if vim.log then vim.log.info(msg) else vim.notify(msg, _levels.info) end
end

--- Log at error level
---@param msg string
M.error = function(msg)
  if vim.log then vim.log.error(msg) else vim.notify(msg, _levels.error) end
end

--- Log at debug level (vim.log only; no vim.notify fallback)
---@param msg string
M.debug = function(msg)
  if vim.log then vim.log.debug(msg) end
end

--- Log at trace level (vim.log only; no vim.notify fallback)
---@param msg string
M.trace = function(msg)
  if vim.log then vim.log.trace(msg) end
end

return M