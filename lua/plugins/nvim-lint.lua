local gh = require('utils').gh

--
local unpack = rawget(_G, 'unpack') or table.unpack

PackageManager.add {
  [1] = gh 'mfussenegger/nvim-lint',
  lazy = false,
  config = function()
    local lint = require 'lint'

    local opts = {

      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      linters_by_ft = {
        fish = { 'fish' },
      },

      linters = {},
    }

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

    local function warn(msg, opts_) vim.notify(msg, vim.log_levels.WARN, vim.tbl_deep_extend('force', { title = 'nvim-lint' }, opts_ or {})) end

    -- One timer per buffer: a single shared timer gets reset on every event,
    -- so jumping between buffers faster than the debounce window would drop the
    -- lint run for the buffer you left. Keying timers by bufnr keeps each
    -- buffer's pending lint independent of the others.
    local timers = {}
    local function debounce(ms, fn)
      return function(bufnr, ...)
        local argv = { ... }
        local timer = timers[bufnr]
        if not timer then
          timer = vim.uv.new_timer()
          timers[bufnr] = timer
        end
        timer:start(ms, 0, function()
          timer:stop()
          timers[bufnr] = nil
          vim.schedule_wrap(fn)(bufnr, unpack(argv))
        end)
      end
    end

    local function lint_buf(bufnr)
      bufnr = bufnr or 0
      local names = lint._resolve_linter_by_ft(vim.bo[bufnr].filetype)

      names = vim.list_extend({}, names)

      if #names == 0 then vim.list_extend(names, lint.linters_by_ft['_'] or {}) end

      vim.list_extend(names, lint.linters_by_ft['*'] or {})

      local ctx = { filename = vim.api.nvim_buf_get_name(bufnr) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ':h')
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then warn('Linter not found: ' .. name) end
        return linter and not (type(linter) == 'table' and linter.condition and not linter.condition(ctx))
      end, names)

      if #names > 0 then
        -- nvim-lint always lints the current buffer, so run inside the target
        -- buffer's context; this keeps the lint correct even if the user moved
        -- to another buffer while the debounce timer was waiting.
        if vim.api.nvim_buf_is_valid(bufnr) then
          vim.api.nvim_buf_call(bufnr, function() lint.try_lint(names) end)
        end
      end
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
      callback = function(args) debounce(100, lint_buf)(args.buf) end,
    })
  end,
}