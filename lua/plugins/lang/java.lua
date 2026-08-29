-- Java language support (treesitter + LSP config).
--
-- jdtls requires the nvim-jdtls plugin, which is NOT installed here.
-- Guard so the server config is registered but never enabled without it.
require('utils').install_with_mason {
  'google-java-format',
  'checkstyle',
}

if pcall(require, 'jdtls') then vim.lsp.config('jdtls', {}) end

local conform = require 'conform'
conform.formatters.google_java_format = {
  command = 'google-java-format',
  stdin = true,
  args = { '--stdin-path' },
}
conform.formatters_by_ft.java = { 'google_java_format' }

require('lint').linters_by_ft.java = { 'checkstyle' }

-- vim: ts=2 sts=2 sw=2 et
