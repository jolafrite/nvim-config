local M = {}

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

M.on_buf_read = function(fn)
  vim.api.nvim_create_autocmd('BufReadPost', {
    once = true,
    callback = function(args) fn(args) end,
  })
end

return M
