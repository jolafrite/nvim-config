PackageManager.add_with_mason {
  'clangd',
  'clang-format',
  'cpplint',
  'codelldb',
}

vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
  },
  filetypes = {
    'c',
    'cpp',
    'cxx',
    'h',
    'hpp',
    'cc',
    'c++',
    'cuda',
    'objc',
    'objcpp',
    'proto',
  },
  root_markers = {
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    'Makefile',
    'configure.in',
    'config.h.in',
    'meson.build',
    'meson_options.txt',
    'build.ninja',
    '.git',
  },
  capabilities = {
    offsetEncoding = { 'utf-16' },
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

-- `clang_format` is a deprecated alias in conform; the built-in `clang-format`
-- definition also adds `-assume-filename`, which is what makes a project's
-- .clang-format apply to stdin formatting.
PackageManager.add_formatter({ 'c', 'cpp', 'cxx', 'h', 'hpp', 'cc' }, 'clang-format')

PackageManager.add_linter({ 'c', 'cpp', 'cxx', 'h', 'hpp', 'cc' }, 'cpplint')

-- codelldb is installed by mason above; wire the adapter and launch/attach
-- configurations so F5 / <leader>dc can start a session.
PackageManager.add_debugger({ 'c', 'cpp' }, 'codelldb', function(dap)
  local codelldb = vim.fn.exepath 'codelldb'
  if codelldb == '' then return end

  dap.adapters.codelldb = {
    type = 'server',
    host = 'localhost',
    port = '${port}',
    executable = { command = codelldb, args = { '--port', '${port}' } },
  }

  for _, ft in ipairs { 'c', 'cpp' } do
    dap.configurations[ft] = {
      {
        type = 'codelldb',
        request = 'launch',
        name = 'Launch file',
        program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
      { type = 'codelldb', request = 'attach', name = 'Attach to process', pid = require('dap.utils').pick_process, cwd = '${workspaceFolder}' },
    }
  end
end)

PackageManager.add_snippets { 'c', 'cpp' }

PackageManager.add_with_treesitter { 'c', 'cpp' }

vim.lsp.enable 'clangd'
