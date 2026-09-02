require('utils').install_with_mason {
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
conform.formatters_by_ft.c = { 'clang_format' }
conform.formatters_by_ft.cpp = { 'clang_format' }
conform.formatters_by_ft.cxx = { 'clang_format' }
conform.formatters_by_ft.h = { 'clang_format' }
conform.formatters_by_ft.hpp = { 'clang_format' }
conform.formatters_by_ft.cc = { 'clang_format' }

require('lint').linters_by_ft.c = { 'cpplint' }
require('lint').linters_by_ft.cpp = { 'cpplint' }
require('lint').linters_by_ft.cxx = { 'cpplint' }
require('lint').linters_by_ft.h = { 'cpplint' }
require('lint').linters_by_ft.hpp = { 'cpplint' }
require('lint').linters_by_ft.cc = { 'cpplint' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'c', 'cpp' })

vim.lsp.enable 'clangd'

