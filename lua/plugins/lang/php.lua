-- vim.g.lazyvim_php_lsp = "intelephense" to switch from phpactor.
PackageManager.add({
  name = 'lang.php',
  filetype = { 'php' },
  config = function()

local lsp = vim.g.lazyvim_php_lsp or 'phpactor'

require('utils').install_with_mason {
  lsp,
  'php-cs-fixer',
  'phpcs',
}

if lsp == 'phpactor' then
  vim.lsp.config('phpactor', {
    cmd = { 'phpactor', 'language-server' },
    filetypes = { 'php' },
    root_markers = { 'composer.json', '.git' },
  })
  vim.lsp.enable 'phpactor'
else
  vim.lsp.config('intelephense', {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_markers = { 'composer.json', '.git' },
  })
  vim.lsp.enable 'intelephense'
end

local conform = require 'conform'
conform.formatters_by_ft.php = { 'php_cs_fixer' }

local lint = require 'lint'
lint.linters_by_ft.php = { 'phpcs' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'php' })
  end,
})

-- vim: ts=2 sts=2 sw=2 et
