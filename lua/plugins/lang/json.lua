-- JSON language support (treesitter + LSP config).
--
-- `json-lsp` from mason installs the `vscode-json-language-server` binary.
-- Schemas are extended with schemastore when the plugin is available.
require('utils').install_with_mason {
	'json-lsp',
	'fixjson',
	'jsonlint',
}

local schemastore_ok, schemastore = pcall(require, "schemastore")

vim.lsp.config("jsonls", {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { ".git" },
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

local conform = require("conform")
conform.formatters.fixjson = {
	command = "fixjson",
	stdin = true,
}
conform.formatters_by_ft.json = { "prettier", "fixjson" }
conform.formatters_by_ft.jsonc = { "prettier", "fixjson" }

require("lint").linters_by_ft.json = { "jsonlint" }
require("lint").linters_by_ft.jsonc = { "jsonlint" }

vim.lsp.enable 'jsonls'

-- vim: ts=2 sts=2 sw=2 et
