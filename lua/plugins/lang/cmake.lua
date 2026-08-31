local gh = require('utils').gh

PackageManager.add({
  [1] = gh 'Civitasv/cmake-tools.nvim',
  filetype = {'cmake'},
  config = function()

require('utils').install_with_mason {
  'neocmakelsp',
  'cmakelang',
  'cmakelint',
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

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'cmake' })

vim.lsp.enable 'neocmake'

-- vim: ts=2 sts=2 sw=2 et
  end,
})

-- vim: ts=2 sts=2 sw=2 et
