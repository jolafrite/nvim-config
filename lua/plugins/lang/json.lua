-- JSON language support (treesitter + LSP config).
--
local schemastore_ok, schemastore = pcall(require, "schemastore")

vim.lsp.config("jsonls", {
	before_init = function(_, new_config)
		new_config.settings.json.schemas = new_config.settings.json.schemas or {}
		if schemastore_ok then
			vim.list_extend(
				new_config.settings.json.schemas,
				schemastore.json.schemas()
			)
		end
	end,
	settings = {
		json = {
			format = { enable = true },
			validate = { enable = true },
		},
	},
})
-- Tree-sitter parser for JSON.
local TS = require("nvim-treesitter")
pcall(TS.install, { "json" })
