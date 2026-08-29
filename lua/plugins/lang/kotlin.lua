-- Kotlin language support (treesitter + LSP config).
--
-- kotlin.nvim provides treesitter + formatting helpers; the LSP server
-- itself is kotlin-language-server (installed via mason).
local gh = require('utils').gh

vim.pack.add {
  gh 'AlexandrosAlexiou/kotlin.nvim',
}

require('utils').install_with_mason {
	'kotlin-language-server',
	'ktfmt',
}

vim.lsp.config('kotlin_language_server', {
	cmd = { 'kotlin-language-server' },
	filetypes = { 'kotlin' },
})

local conform = require("conform")
conform.formatters.ktfmt_fmt = {
	command = "ktfmt",
	stdin = true,
	args = { "--stdin" },
}
conform.formatters_by_ft.kotlin = { "ktfmt_fmt" }

vim.lsp.enable 'kotlin_language_server'

-- vim: ts=2 sts=2 sw=2 et
