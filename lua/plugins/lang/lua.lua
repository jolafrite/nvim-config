-- Lua language support.
--
-- lua-language-server and stylua are installed via mason rather than
-- invoked directly, so the same binaries work whether or not a Homebrew
-- install exists. The mason install is kicked off on FileType "lua" and
-- runs async; mason's own success handler fires `do FileType` again so
-- the lua_ls enable below re-runs once the server is actually installed.
require('utils').on_file_types({ 'lua' }, function()
	local mr = require 'mason-registry'
	mr.refresh(function()
		for _, tool in ipairs({ 'lua-language-server', 'stylua' }) do
			local p = mr.get_package(tool)
			if not p:is_installed() then p:install() end
		end
	end)

	vim.lsp.config('lua_ls', {
		cmd = { 'lua-language-server' },
		filetypes = { 'lua' },
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
					path = vim.split(vim.o.runtimepath, ','),
				},
				diagnostics = {
					globals = { 'vim' },
					groupSeverity = {
						strong = 'Warning',
						strict = 'Warning',
					},
					undefinedGlobal = 'Warning',
				},
				workspace = {
					checkThirdParty = false,
				},
				telemetry = { enable = false },
			},
		},
	})

	vim.lsp.enable('lua_ls')

	local conform = require 'conform'
	conform.formatters_by_ft.lua = { 'stylua' }
end)
