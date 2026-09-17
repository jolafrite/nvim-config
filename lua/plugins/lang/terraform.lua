PackageManager.add_with_mason {
  'terraform-ls',
  'tflint',
}

vim.lsp.config('terraformls', {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'terraform-vars' },
  root_markers = { '.terraform', '.git' },
})

-- conform's built-in terraform_fmt already runs `terraform fmt -no-color -`.
PackageManager.add_formatter({ 'terraform', 'tf', 'terraform-vars' }, 'terraform_fmt')

-- packer is not installed by mason; conform's built-in packer_fmt only runs
-- when the binary is on PATH.
PackageManager.add_formatter('hcl', 'packer_fmt', function(conform)
  conform.formatters.packer_fmt = {
    condition = function() return vim.fn.executable 'packer' == 1 end,
  }
end)

-- terraform_validate shells out to the terraform binary (and needs an
-- initialised working directory), so skip it unless terraform is installed.
PackageManager.add_linter({ 'terraform', 'tf', 'terraform-vars' }, { 'tflint', 'terraform_validate' }, function(lint)
  lint.linters.terraform_validate = vim.tbl_deep_extend('force', lint.linters.terraform_validate or {}, {
    condition = function() return vim.fn.executable 'terraform' == 1 end,
  })
end)

PackageManager.add_with_treesitter { 'terraform', 'hcl' }

-- *.tfvars has no parser of its own; the terraform grammar covers it, and
-- get_lang() only strips subfiletypes (yaml.docker-compose -> yaml).
vim.treesitter.language.register('terraform', 'terraform-vars')

vim.lsp.enable 'terraformls'
