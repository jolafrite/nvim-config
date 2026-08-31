local M = {}

---@param name string
---@param clear? boolean
M.new_group = function(name, clear) return vim.api.nvim_create_augroup('myconfig_utils_autocmd_' .. name, { clear = clear }) end

M.default_group = M.new_group('default', true)

-- Register an autocmd that fires once per matching filetype, runs the callback.
M.on_file_types = function(patterns, fn)
  local list = type(patterns) == 'string' and { patterns } or patterns

  ---@param args { buf: integer }
  local function run(args)
    fn(args)
    vim.cmd('runtime! ftplugin/' .. vim.bo[args.buf].filetype .. '.lua')
    vim.cmd('runtime! ftplugin/' .. vim.bo[args.buf].filetype .. '.vim')
  end

  vim.api.nvim_create_autocmd('FileType', {
    pattern = list,
    callback = run,
  })

  -- If the current buffer's FileType event already fired before this helper
  -- was registered — e.g. when called from inside a PackageManager spec
  -- config that the current buffer itself triggered — the autocmd above would
  -- miss it. Run the callback for the current buffer now instead.
  local ft = vim.bo.filetype
  if ft ~= '' and (vim.tbl_contains(list, '*') or vim.tbl_contains(list, ft)) then
    run { buf = vim.api.nvim_get_current_buf() }
  end
end

-- Register a callback that runs once when the first real buffer is
-- opened. Equivalent to on_file_types('*') but reads as intent.
M.on_buf_read = function(fn)
  vim.api.nvim_create_autocmd('BufReadPost', {
    once = true,
    callback = function(args) fn(args) end,
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
