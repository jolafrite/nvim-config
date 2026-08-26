-- LSP configuration: mirrors LazyVim's defaults for the servers that
-- are configured by the lang extras (rust, go, typescript, kotlin).

local function lspconfig_setup()
	local lspconfig = require("lspconfig")

	-- Default capabilities applied to all servers.
	local capabilities = vim.lsp.make_client_capabilities()
	capabilities.workspace = capabilities.workspace or {}
	capabilities.workspace.fileOperations = {
		didRename = true,
		willRename = true,
	}

	-- Default options for vim.lsp.config("*").
	lspconfig.setup({
		capabilities = capabilities,
	})

	-- rust-analyzer
	lspconfig.rust_analyzer.setup({
		cargo = { allFeatures = true, loadOutDirsFromCheck = true, buildScripts = { enable = true } },
		checkOnSave = true,
		diagnostics = { enable = true },
		procMacro = { enable = true },
		files = {
			exclude = {
				".direnv",
				".git",
				".jj",
				".github",
				".gitlab",
				"bin",
				"node_modules",
				"target",
				"venv",
				".venv",
			},
			watcher = "client",
		},
	})

	-- gopls
	lspconfig.gopls.setup({
		init_options = { semanticTokens = true },
		settings = {
			gopls = {
				gofumpt = true,
				codelenses = {
					gc_details = false,
					generate = true,
					regenerate_cgo = true,
					run_govulncheck = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					vendor = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				analyses = {
					nilness = true,
					unusedparams = true,
					unusedwrite = true,
					useany = true,
				},
				usePlaceholders = true,
				completeUnimported = true,
				staticcheck = true,
				directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
			},
		},
	})

	-- Workaround for gopls not supporting semanticTokensProvider.
	require("snacks").util.lsp.on({ name = "gopls" }, function(_, client)
		if
			client.config
			and client.config.init_options
			and client.config.init_options.semanticTokens
			and not client.server_capabilities.semanticTokensProvider
		then
			local semantic = client.config.capabilities.textDocument.semanticTokens
			client.server_capabilities.semanticTokensProvider = {
				full = true,
				legend = {
					tokenTypes = semantic.tokenTypes,
					tokenModifiers = semantic.tokenModifiers,
				},
				range = true,
			}
		end
	end)

	-- tsserver (typescript-language-server)
	lspconfig.tsserver.setup({})

	-- kotlin-language-server
	lspconfig.kotlin_language_server.setup({})
end

local function mason_setup()
	local ensure_installed = {
		"stylua",
		"shfmt",
	}

	require("mason").setup({
		ensure_installed = ensure_installed,
	})

	local mr = require("mason-registry")
	mr:on("package:install:success", function()
		vim.defer_fn(function()
			-- trigger FileType event to possibly load this newly installed LSP server
			vim.cmd([[do FileType]])
		end, 100)
	end)

	mr.refresh(function()
		for _, tool in ipairs(ensure_installed) do
			local p = mr.get_package(tool)
			if not p:is_installed() then
				p:install()
			end
		end
	end)
end

local function mason_lspconfig_setup()
	-- Ensure the LSP servers we want are installed by mason-lspconfig.
	require("mason-lspconfig").setup({
		ensure_installed = {
			"rust-analyzer",
			"gopls",
			"tsserver",
			"kotlin-language-server",
		},
		automatic_enable = { exclude = {} },
	})
end

local M = {}

function M.setup()
	lspconfig_setup()
	mason_setup()
	mason_lspconfig_setup()
end

return M