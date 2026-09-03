PackageManager.add_with_mason {
  'clangd',
  'clang-format',
  'cpplint',
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

local conform = require 'conform'
conform.formatters.clang_format = {
  command = 'clang-format',
  stdin = true,
}
PackageManager.add_formatter({ 'c', 'cpp', 'cxx', 'h', 'hpp', 'cc' }, 'clang_format')

PackageManager.add_linter({ 'c', 'cpp', 'cxx', 'h', 'hpp', 'cc' }, 'cpplint')

PackageManager.add_with_treesitter({ 'c', 'cpp' })

vim.lsp.enable 'clangd'
