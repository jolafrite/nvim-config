local gh = require 'utils'

vim.pack.add {
  gh 'Saecki/crates.nvim',
}

require('utils').install_with_mason {
  'rust-analyzer',
}

vim.vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json' },
})

vim.lsp.enable 'rust_analyzer'

require('Saecki/crates.nvim').setup()

require('conform').formatters_by_ft.rust = { 'rustfmt' }

require('conform').formatters.rustfmt = {
  command = 'rustfmt',
  stdin = true,
  args = { '--emit=stdout' },
}

require('lint').linters_by_ft.rust = { 'clippy' }

require('lint').linters.clippy = vim.tbl_deep_extend('force', require('lint').linters.clippy, { ignore_exitcode = true })

-- vim: ts=2 sts=2 sw=2 et
