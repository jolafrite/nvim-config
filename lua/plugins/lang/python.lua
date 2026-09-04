local lsp = vim.g.python_lsp or 'pyright'
local ruff = 'ruff'

PackageManager.add_with_mason { lsp, ruff, 'debugpy' }

vim.lsp.config(lsp, {
  cmd = lsp == 'basedpyright' and { 'basedpyright-langserver', '--stdio' } or { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  settings = {
    pyright = { disableTaggedHints = true },
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
})

vim.lsp.config(ruff, {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  cmd_env = { RUFF_TRACE = 'messages' },
  init_options = {
    settings = {
      logLevel = 'error',
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == ruff then client.server_capabilities.hoverProvider = false end
  end,
})

PackageManager.add_with_treesitter { 'python', 'ninja', 'rst' }

PackageManager.add_formatter(
  'python',
  'ruff',
  function(conform)
    conform.formatters.ruff = {
      command = 'ruff',
      stdin = true,
      args = { 'format', '-' },
    }
  end
)

PackageManager.add_linter('python', { ruff, 'mypy', 'flake8' })

PackageManager.add_debugger('python', 'debugpy')

PackageManager.add_snippets 'python'

vim.lsp.enable(lsp)
vim.lsp.enable(ruff)
