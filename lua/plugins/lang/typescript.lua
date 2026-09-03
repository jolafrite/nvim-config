local gh = require('utils').gh

PackageManager.add_with_mason {
  'oxlint',
  'oxfmt',
  'prettierd',
  'js-debug-adapter',
}
PackageManager.add_with_treesitter { 'typescript', 'tsx', 'javascript' }

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  root_markers = {
    'tsconfig.json',
    'package.json',
    'jsconfig.json',
    '.git',
  },
  settings = {
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
    javascript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
    },
  },
})

vim.lsp.config('oxlint', {
  cmd = { 'oxlint', '--lsp' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'vue',
    'svelte',
    'astro',
  },
  settings = {
    fixKind = 'all',
  },
})

PackageManager.add_formatter({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, 'prettierd')
PackageManager.add_linter({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, 'oxlint')

PackageManager.add_debugger({ 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, 'js-debug-adapter')

PackageManager.add_snippets { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

vim.lsp.enable 'ts_ls'
vim.lsp.enable 'oxlint'

PackageManager.add {
  [1] = gh 'Sebastian-Nielsen/better-type-hover',
  filetype = { 'typescript', 'typescriptreact' },
  config = function()
    local ok, bth = pcall(require, 'better-type-hover')
    if not ok then return end

    bth.config = bth.config or {}

    vim.keymap.set('n', '<C-P>', bth.better_type_hover, {
      buffer = 0,
      desc = 'Better type hover',
    })
  end,
}
