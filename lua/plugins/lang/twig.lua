PackageManager.add_with_mason {
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
PackageManager.add_formatter('twig', 'twig-cs-fixer')

PackageManager.add_linter('twig', 'twigcs')

PackageManager.add_with_treesitter({ 'twig' })

vim.lsp.enable 'twiggy_language_server'
