-- TOML language support (treesitter + LSP config).
require('utils').install_with_mason {
	'taplo',
}

vim.lsp.config('taplo', {
	cmd = { 'taplo', 'lsp', 'stdio' },
	filetypes = { 'toml' },
	root_markers = { '.taplo.toml', 'taplo.toml', '.git' },
})

vim.lsp.enable 'taplo'

-- vim: ts=2 sts=2 sw=2 et
