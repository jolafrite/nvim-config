-- CMake language support (treesitter + LSP config).
require('utils').install_with_mason {
  'neocmakelsp',
  'cmakelang',
}

vim.lsp.config('neocmake', {
  cmd = { 'neocmakelsp', 'stdio' },
  filetypes = { 'cmake' },
  root_markers = { '.neocmake.toml', '.git', 'build', 'cmake' },
})

local conform = require 'conform'
conform.formatters.cmake_format = {
  command = 'cmake-format',
  stdin = true,
}
conform.formatters_by_ft.cmake = { 'cmake_format' }

local lint = require 'lint'
lint.linters_by_ft.cmake = { 'cmakelint' }

vim.lsp.enable 'neocmake'

-- vim: ts=2 sts=2 sw=2 et
