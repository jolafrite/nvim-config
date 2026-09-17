local lsp = vim.g.python_lsp or 'pyright'
local ruff = 'ruff'

PackageManager.add_with_mason { lsp, ruff, 'mypy', 'debugpy' }

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
  group = vim.api.nvim_create_augroup('python_lsp', { clear = true }),
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

-- ruff implements the flake8 rule set, so flake8 is not registered (and not
-- installed); both linters below are installed by mason above.
PackageManager.add_linter('python', { ruff, 'mypy' })

-- debugpy is installed by mason above. Prefer nvim-dap-python with mason's
-- debugpy venv (gives the test runners too); fall back to the `debugpy-adapter`
-- shim that mason puts on PATH.
PackageManager.add_debugger('python', 'debugpy', function(dap)
  local is_win = vim.fn.has 'win32' == 1
  local venv = require('utils').mason_path('debugpy', 'venv', is_win and 'Scripts' or 'bin', is_win and 'python.exe' or 'python')

  local ok, dap_python = pcall(require, 'dap-python')
  if ok and venv and vim.fn.executable(venv) == 1 then
    dap_python.setup(venv)
    return
  end

  dap.adapters.python = { type = 'executable', command = 'debugpy-adapter' }
  dap.configurations.python = {
    { type = 'python', request = 'launch', name = 'Launch file', program = '${file}' },
    { type = 'python', request = 'attach', name = 'Attach', connect = { host = 'localhost', port = 5678 } },
  }
end)

PackageManager.add_snippets 'python'

vim.lsp.enable(lsp)
vim.lsp.enable(ruff)
