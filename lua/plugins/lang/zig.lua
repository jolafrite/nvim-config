-- Zig language support (treesitter + LSP config).
require("utils").install_with_mason({
	"zls",
})

vim.lsp.config("zls", {
	cmd = { "zls" },
	filetypes = { "zig", "zir" },
	root_markers = { "zls.json", "build.zig", ".git" },
})

vim.lsp.enable("zls")

-- vim: ts=2 sts=2 sw=2 et
