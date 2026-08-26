require("mason-lspconfig").setup({
	ensure_installed = {
		"rust-analyzer",
		"gopls",
		"tsserver",
		"kotlin-language-server",
	},
	automatic_enable = { exclude = {} },
})