PackageManager.add_with_mason {
  'twiggy-language-server',
  'twigcs',
  'twig-cs-fixer',
}

vim.lsp.config('twiggy_language_server', {
  cmd = { 'twiggy-language-server' },
  filetypes = { 'twig', 'html.twig' },
})

PackageManager.add_formatter(
  'twig',
  'twig-cs-fixer',
  function(conform)
    conform.formatters['twig-cs-fixer'] = {
      command = 'twig-cs-fixer',
      args = { 'fix', '--config=.twig-cs-fixer.php' },
    }
  end
)

PackageManager.add_linter('twig', 'twigcs')

PackageManager.add_with_treesitter { 'twig' }

vim.lsp.enable 'twiggy_language_server'
