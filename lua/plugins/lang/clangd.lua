-- Clangd language support (treesitter + LSP config).
require('utils').install_with_mason {
	'clangd',
}

vim.lsp.config('clangd',
	{
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
			'c', 'cpp', 'cxx', 'h', 'hpp', 'cc', 'c++', 'cuda', 'objc',
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

vim.lsp.enable 'clangd'

-- vim: ts=2 sts=2 sw=2 et
