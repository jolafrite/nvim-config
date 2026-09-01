local M = {}

-- Register a callback that runs once when the first LSP client attaches.
M.on_lsp_attach = function(fn)
  vim.api.nvim_create_autocmd('LspAttach', {
    once = true,
    callback = function(args) fn(args) end,
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
