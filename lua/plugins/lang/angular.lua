-- Angular language support (treesitter + LSP config).
--
-- Depends on typescript/ts_ls (loaded in lsp.lua before this module).
--
-- `angular-language-server` from mason installs the `ngserver` binary.
-- When @angular/language-server is installed globally, `ngserver --stdio`
-- is sufficient; the nvim-lspconfig default additionally probes
-- project-local node_modules for per-project Angular versions.
require("utils").install_with_mason({
	"angular-language-server",
})

vim.lsp.config("angularls", {
	cmd = { "ngserver", "--stdio" },
	filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
	root_markers = { "angular.json", "nx.json" },
})

require("snacks").util.lsp.on({ name = "angularls" }, function(_, client)
	-- HACK: disable angular renaming capability due to duplicate rename popping up
	client.server_capabilities.renameProvider = false
end)

vim.lsp.enable("angularls")

-- vim: ts=2 sts=2 sw=2 et
