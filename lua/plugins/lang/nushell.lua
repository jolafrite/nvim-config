-- nushell is not mason-installable; `nu --lsp` comes with the nushell install.
if vim.fn.executable 'nu' == 1 then
  vim.lsp.config('nushell', {
    cmd = { 'nu', '--lsp' },
    filetypes = { 'nu' },
  })

  PackageManager.add_with_treesitter { 'nu' }

  vim.lsp.enable 'nushell'
end
