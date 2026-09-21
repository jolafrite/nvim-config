PackageManager.add_with_mason {
  'terraform-ls',
  'tflint',
}

vim.lsp.config('terraformls', {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
})

PackageManager.add_formatter({ 'terraform', 'tf', 'terraform-vars' }, 'terraform_fmt')

PackageManager.add_formatter('hcl', 'packer_fmt', function(conform)
  conform.formatters.packer_fmt = {
    condition = function() return vim.fn.executable 'packer' == 1 end,
  }
end)

PackageManager.add_linter({ 'terraform', 'tf', 'terraform-vars' }, { 'tflint', 'terraform_validate' }, function(lint)
  local original = lint.linters.terraform_validate
  lint.linters.terraform_validate = function(...)
    if vim.fn.executable('terraform') == 0 then return nil end
    return original(...)
  end
end)

PackageManager.add_with_treesitter { 'terraform', 'hcl' }

vim.treesitter.language.register('terraform', 'terraform-vars')

vim.lsp.enable 'terraformls'
