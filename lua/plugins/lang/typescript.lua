local gh = require('utils').gh

-- Filetypes served by ts_ls / oxlint / prettierd / js-debug-adapter.
local js_fts = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }

PackageManager.add_with_mason {
  'typescript-language-server',
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

PackageManager.add_formatter(js_fts, 'prettierd')
PackageManager.add_linter(js_fts, 'oxlint')

-- js-debug-adapter is a node "server" adapter; mason ships the dapDebugServer.js
-- entry point, so resolve it through mason instead of assuming a global install.
PackageManager.add_debugger(js_fts, 'js-debug-adapter', function(dap)
  local server = require('utils').mason_path('js-debug-adapter', 'js-debug', 'src', 'dapDebugServer.js')
  if not server or vim.fn.filereadable(server) == 0 or vim.fn.executable 'node' == 0 then return end

  dap.adapters['pwa-node'] = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = { command = 'node', args = { server, '${port}' } },
  }

  for _, ft in ipairs(js_fts) do
    dap.configurations[ft] = {
      { type = 'pwa-node', request = 'launch', name = 'Launch file', program = '${file}', cwd = '${workspaceFolder}' },
      { type = 'pwa-node', request = 'attach', name = 'Attach to process', processId = require('dap.utils').pick_process, cwd = '${workspaceFolder}' },
    }
  end
end)

PackageManager.add_snippets(js_fts)

vim.lsp.enable 'ts_ls'
vim.lsp.enable 'oxlint'

PackageManager.add {
  [1] = gh 'Sebastian-Nielsen/better-type-hover',
  filetype = { 'typescript', 'typescriptreact' },
  config = function()
    local ok, bth = pcall(require, 'better-type-hover')
    if not ok then return end

    bth.config = bth.config or {}

    -- This spec is only loaded once (for the first .ts/.tsx buffer), so map the
    -- hover per filetype instead of only on the buffer that triggered the load.
    require('utils').on_file_types({ 'typescript', 'typescriptreact' }, function()
      vim.keymap.set('n', '<C-P>', bth.better_type_hover, { buffer = true, desc = 'Better type hover' })
    end)
  end,
}
