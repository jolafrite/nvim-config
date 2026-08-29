-- Tailwind CSS language support (treesitter + LSP config).
require('utils').install_with_mason {
	'tailwindcss-language-server',
}

vim.lsp.config('tailwindcss',
	{
		cmd = { 'tailwindcss-language-server', '--stdio' },
		filetypes = {
			'html', 'css', 'javascript', 'javascriptreact', 'typescript',
			'typescriptreact', 'svelte', 'astro', 'templ', 'php', 'blade',
			'markdown', 'mdx',
		},
		settings = {
			tailwindCSS = {
				includeLanguages = {
					elixir = "html-eex",
					eelixir = "html-eex",
					heex = "html-eex",
				},
			},
		},
	})

vim.lsp.enable 'tailwindcss'

-- vim: ts=2 sts=2 sw=2 et
