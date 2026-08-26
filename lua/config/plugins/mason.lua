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
