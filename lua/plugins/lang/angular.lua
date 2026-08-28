-- Angular language support (treesitter + LSP config).
--
-- Depends on typescript/ts_ls (loaded in lsp.lua before this module).
vim.lsp.config('angularls', {})
require("snacks").util.lsp.on({ name = "angularls" }, function(_, client)
	-- HACK: disable angular renaming capability due to duplicate rename popping up
	client.server_capabilities.renameProvider = false
end)
