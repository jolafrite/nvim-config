require('utils').install_with_mason {
  'twiggy-language-server',
  'twigcs',
  'twig-cs-fixer',
}

vim.lsp.config('twiggy_language_server', {
  cmd = { 'twiggy-language-server' },
  filetypes = { 'twig', 'html.twig' },
})

local conform = require 'conform'
conform.formatters['twig-cs-fixer'] = {
  command = 'twig-cs-fixer',
  args = { 'fix', '--config=.twig-cs-fixer.php' },
}
conform.formatters_by_ft.twig = { 'twig-cs-fixer' }

local lint = require 'lint'
lint.linters_by_ft.twig = { 'twigcs' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'twig' })

vim.lsp.enable 'twiggy_language_server'

