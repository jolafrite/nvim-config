local lsp = vim.g.ruby_lsp or 'ruby_lsp'
local formatter = vim.g.ruby_formatter or 'rubocop'

PackageManager.add_with_mason {
  lsp,
  'rubocop',
  'standardrb',
  'erb-formatter',
  'erb-lint',
}

if lsp == 'ruby_lsp' then
  vim.lsp.config('ruby_lsp', {
    cmd = { 'ruby-lsp' },
    filetypes = { 'ruby' },
    root_markers = { 'Gemfile', 'Rakefile', '.git' },
  })
  vim.lsp.enable 'ruby_lsp'
else
  vim.lsp.config('solargraph', {
    cmd = { 'solargraph', 'stdio' },
    filetypes = { 'ruby' },
    root_markers = { 'Gemfile', 'Rakefile', '.git' },
  })
  vim.lsp.enable 'solargraph'
end

if formatter == 'rubocop' and lsp ~= 'solargraph' then
  vim.lsp.config('rubocop', {
    cmd = { 'rubocop', '--lsp' },
    filetypes = { 'ruby' },
  })
  vim.lsp.enable 'rubocop'
end

PackageManager.add_with_treesitter { 'ruby' }

PackageManager.add_formatter({ 'ruby', 'eruby' }, { formatter, 'erb_format' })
