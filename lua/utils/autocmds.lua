local M = {}

---@param name string
---@param clear? boolean
M.new_group = function(name, clear) return vim.api.nvim_create_augroup('myconfig_utils_autocmd_' .. name, { clear = clear }) end

M.default_group = M.new_group('default', true)

-- Register an autocmd that fires once per matching filetype, runs the callback.
M.on_file_types = function(patterns, fn)
  local list = type(patterns) == 'string' and { patterns } or patterns
  vim.api.nvim_create_autocmd('FileType', {
    pattern = list,
    callback = function(args)
      fn(args)
      vim.cmd('runtime! ftplugin/' .. vim.bo.filetype .. '.lua')
      vim.cmd('runtime! ftplugin/' .. vim.bo.filetype .. '.vim')
    end,
  })
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
