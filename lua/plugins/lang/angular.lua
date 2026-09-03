PackageManager.add_with_mason {
  'angular-language-server',
  'prettierd',
  'oxlint',
}

vim.lsp.config('angularls', {
  cmd = { 'ngserver', '--stdio' },
  filetypes = { 'typescript', 'html', 'typescriptreact', 'htmlangular' },
  root_markers = { 'angular.json', 'nx.json' },
})

PackageManager.add_formatter('htmlangular', 'prettierd')
PackageManager.add_linter('htmlangular', 'oxlint')

PackageManager.add_with_treesitter { 'angular', 'scss' }

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = { '*.component.html', '*.container.html' },
  callback = function()
    vim.bo.filetype = 'htmlangular'
    pcall(vim.treesitter.start, nil, 'angular')
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'angularls' then client.server_capabilities.renameProvider = false end
  end,
})

vim.lsp.enable 'angularls'
