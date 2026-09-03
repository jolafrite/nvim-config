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

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'angular', 'scss' })

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = { '*.component.html', '*.container.html' },
  callback = function()
    vim.bo.filetype = 'htmlangular'
    pcall(vim.treesitter.start, nil, 'angular')
  end,
})

require('snacks').util.lsp.on({ name = 'angularls' }, function(_, client) client.server_capabilities.renameProvider = false end)

vim.lsp.enable 'angularls'
