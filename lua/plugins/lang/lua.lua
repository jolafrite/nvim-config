require('utils').install_with_mason {
	'lua-language-server',
	'stylua',
	'selene',
}

vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = {
		'.luarc.json',
		'.luarc.jsonc',
		'.luacheckrc',
		'.stylua.toml',
		'stylua.toml',
		'selene.toml',
		'selene.yml',
		'.git',
	},

	on_init = function(client) client.server_capabilities.documentFormattingProvider = false end,

	settings = {
		Lua = {
			signatureHelp = { enabled = true },
			format = { enable = false },
			codeLens = { enable = true },
			hint = { enable = true },
		},
	},
})


local conform = require 'conform'
conform.formatters_by_ft.lua = { 'stylua' }

local lint = require 'lint'
if vim.uv.fs_stat(vim.fn.expand '~/.cargo/bin/selene') then lint.linters.selene.cmd =
	vim.fn.expand '~/.cargo/bin/selene' end
lint.linters_by_ft.lua = { 'selene' }

vim.lsp.enable 'lua_ls'
