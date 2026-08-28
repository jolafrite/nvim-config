-- Tailwind CSS language support (treesitter + LSP config).
vim.lsp.config('tailwindcss',
{
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
