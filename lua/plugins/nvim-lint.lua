local gh = require('utils').gh

vim.pack.add {
  gh 'mfussenegger/nvim-lint',
}

-- nvim-lint configuration: mirrors the default linting setup.
--
-- Provides the `<leader>ciL` keymap (in keymaps.lua) with the linters_by_ft
-- table, a debounce helper, and the autocmd that triggers linting on
-- BufWritePost / BufReadPost / InsertLeave.

local lint = require 'lint'

local opts = {
  -- Event to trigger linters
  events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
  linters_by_ft = {
    fish = { 'fish' },
  },
-- Extension point: easily override linter options or add custom linters.
  linters = {},
}

-- Apply custom linters (extension: deep-extend + prepend_args).
for name, linter in pairs(opts.linters) do
  if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
    lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
    if type(linter.prepend_args) == 'table' then
      lint.linters[name].args = lint.linters[name].args or {}
      vim.list_extend(lint.linters[name].args, linter.prepend_args)
    end
  else
    lint.linters[name] = linter
  end
end
lint.linters_by_ft = opts.linters_by_ft

local M = {}

-- Warn helper: notify at warn level instead of dropping the feature.
local function warn(msg, opts_) vim.notify(msg, vim.log_levels.WARN, vim.tbl_deep_extend('force', { title = 'nvim-lint' }, opts_ or {})) end

function M.debounce(ms, fn)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

function M.lint()
  -- Use nvim-lint's logic first:
  -- * checks if linters exist for the full filetype first
  -- * otherwise will split filetype by "." and add all those linters
  -- * this differs from conform.nvim which only uses the first filetype that has a formatter
  local names = lint._resolve_linter_by_ft(vim.bo.filetype)

  -- Create a copy of the names table to avoid modifying the original.
  names = vim.list_extend({}, names)

  -- Add fallback linters.
  if #names == 0 then vim.list_extend(names, lint.linters_by_ft['_'] or {}) end

  -- Add global linters.
  vim.list_extend(names, lint.linters_by_ft['*'] or {})

  -- Filter out linters that don't exist or don't match the condition.
  local ctx = { filename = vim.api.nvim_buf_get_name(0) }
  ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
  names = vim.tbl_filter(function(name)
    local linter = lint.linters[name]
    if not linter then warn('Linter not found: ' .. name) end
    return linter and not (type(linter) == 'table' and linter.condition and not linter.condition(ctx))
  end, names)

  -- Run linters.
  if #names > 0 then lint.try_lint(names) end
end

vim.api.nvim_create_autocmd(opts.events, {
  group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
  callback = M.debounce(100, M.lint),
})

local linters = function()
  local linters_attached = require('lint').linters_by_ft[vim.bo.filetype]
  local buf_linters = {}

  if not linters_attached then
    vim.notify('No linters attached', { title = 'Linter' })
    return
  end

  for _, linter in pairs(linters_attached) do
    table.insert(buf_linters, linter)
  end

  local unique_client_names = table.concat(buf_linters, ', ')
  local linters = string.format('%s', unique_client_names)

  vim.notify(linters, { title = 'Linter' })
end
vim.keymap.set('n', '<leader>ciL', linters, { desc = 'Lint' })
