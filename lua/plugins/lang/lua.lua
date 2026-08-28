-- Lua language support.
vim.lsp.config('lua_ls',
{
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(vim.o.runtimepath, ","),
			},
			diagnostics = {
				globals = { "vim" },
				groupSeverity = {
					strong = "Warning",
					strict = "Warning",
				},
				undefinedGlobal = "Warning",
			},
			workspace = {
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

-- stylua is the formatter for Lua (installed via mason.lua).
local conform = require("conform")
conform.formatters_by_ft.lua = { "stylua" }
