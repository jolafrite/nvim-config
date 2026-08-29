-- Angular language support (treesitter + LSP config).
--
-- Depends on typescript/ts_ls (loaded in lsp.lua before this module).
--
-- `angular-language-server` from mason installs the `ngserver` binary.
-- When @angular/language-server is installed globally, `ngserver --stdio`
-- is sufficient; the nvim-lspconfig default additionally probes
-- project-local node_modules for per-project Angular versions.
require('utils').install_with_mason {
  'angular-language-server',
  'prettier',
  'oxlint',
}

vim.lsp.config('angularls', {
  cmd = { 'ngserver', '--stdio' },
  filetypes = { 'typescript', 'html', 'typescriptreact', 'htmlangular' },
  root_markers = { 'angular.json', 'nx.json' },
})

local conform = require 'conform'
conform.formatters.prettier = {
  command = 'prettier',
  stdin = true,
}
conform.formatters_by_ft.htmlangular = { 'prettier' }

require('lint').linters_by_ft.htmlangular = { 'oxlint' }

-- Tree-sitter parsers for Angular (templates use the `angular` parser,
-- styles use `scss`).
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'angular', 'scss' })

-- Angular component/container templates share the .html extension but the
-- code inside them is Angular, not plain HTML. Start the `angular` parser
-- (and re-run filetype detection) so highlighting matches the template syntax.
vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  pattern = { '*.component.html', '*.container.html' },
  callback = function()
    vim.bo.filetype = 'htmlangular'
    pcall(vim.treesitter.start, nil, 'angular')
  end,
})

require('snacks').util.lsp.on({ name = 'angularls' }, function(_, client)
  -- HACK: disable angular renaming capability due to duplicate rename popping up
  client.server_capabilities.renameProvider = false
end)

vim.lsp.enable 'angularls'

-- vim: ts=2 sts=2 sw=2 et
