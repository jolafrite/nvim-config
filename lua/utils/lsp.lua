local get_filename = require('utils.path').get_filename

local M = {}

-- Register a callback that runs once when the first LSP client attaches.
M.on_lsp_attach = function(fn)
  vim.api.nvim_create_autocmd('LSPAttach', {
    once = true,
    callback = function(args) fn(args) end,
  })
end

M.get_lua_filenames_without_extension = function()
  local filenames = vim.fn.glob(vim.fn.stdpath 'config' .. '/lsp/*.lua')
  local filename_table = vim.split(filenames, '\n')
  local result = {}
  for _, path in ipairs(filename_table) do
    local fn = get_filename(path)
    if fn:match 'init%.lua$' then goto continue end
    local name = vim.fn.fnamemodify(fn, ':r')
    table.insert(result, name)
    ::continue::
  end
  return result
end

return M

-- vim: ts=2 sts=2 sw=2 et
