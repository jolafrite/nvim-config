-- Angular templates. NOTE: no dependency on typescript.lua — angularls handles
-- the embedded TS in templates itself, and typescript.lua is lazy anyway.
-- Hoisted so `htmlangular` is detectable before the spec's filetype trigger
-- fires (Neovim core does not map these on its own; patterns are Lua patterns,
-- not globs).
vim.filetype.add {
  pattern = {
    ['.*%.component%.html'] = 'htmlangular',
    ['.*%.container%.html'] = 'htmlangular',
  },
}

PackageManager.add({
  name = 'lang.angular',
  filetype = { 'htmlangular' },
  config = function()

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

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'angular', 'scss' })

-- `*.component.html` / `*.container.html` are Angular templates, not plain HTML.
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

-- Start highlighting for the buffer that triggered this load; its FileType
-- event already fired (before the parser was installed), so the treesitter
-- plugin's own FileType autocmd missed it.
pcall(vim.treesitter.start, nil, 'angular')
  end,
})

-- vim: ts=2 sts=2 sw=2 et
