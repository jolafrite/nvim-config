-- Terraform language support (treesitter + LSP config).
vim.lsp.config('terraformls', {})
local conform = require("conform")
conform.formatters_by_ft.terraform = { "terraform_fmt" }
conform.formatters_by_ft.tf = { "terraform_fmt" }
conform.formatters_by_ft["terraform-vars"] = { "terraform_fmt" }
conform.formatters_by_ft.hcl = { "packer_fmt" }

local lint = require("lint")
lint.linters_by_ft.terraform = { "terraform_validate" }
lint.linters_by_ft.tf = { "terraform_validate" }
lint.linters_by_ft["terraform-vars"] = { "terraform_validate" }
