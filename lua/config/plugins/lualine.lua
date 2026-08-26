local lualine_require = require("lualine_require")
lualine_require.require = require

local icons = {
	misc = { dots = "󰇘" },
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
	git = {
		added = " ",
		modified = " ",
		removed = " ",
	},
}

-- minimal root detector using vim.g.root_spec
local function root_get()
	local spec = vim.g.root_spec or { "lsp", { ".git" }, "cwd" }
	for _, entry in ipairs(spec) do
		if type(entry) == "function" then
			local ok, res = pcall(entry, 0)
			if ok and res then
				if type(res) == "table" then
					res = res[1]
				end
				if res then
					return res
				end
			end
		end
	end
	return vim.uv.cwd()
end

local function root_cwd()
	return vim.uv.cwd()
end

local function pretty_path(opts)
	opts = vim.tbl_extend("force", {
		relative = "cwd",
		modified_hl = "MatchParen",
		directory_hl = "",
		filename_hl = "Bold",
		modified_sign = "",
		readonly_icon = " 󰌾 ",
		length = 3,
	}, opts or {})

	return function(self)
		local path = vim.fn.expand("%:p")
		if path == "" then
			return ""
		end

		local root = root_get()
		local cwd = root_cwd()
		local norm_path = path

		if opts.relative == "cwd" and norm_path:find(cwd, 1, true) == 1 then
			path = path:sub(#cwd + 2)
		end

		local sep = package.config:sub(1, 1)
		local parts = vim.split(path, "[\\/]")

		if #parts > opts.length then
			parts =
				{ parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
		end

		local dir = ""
		if #parts > 1 then
			dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep) .. sep
		end

		local readonly = vim.bo.readonly and opts.readonly_icon or ""
		return dir .. parts[#parts] .. readonly
	end
end

local function root_dir(opts)
	opts = vim.tbl_extend("force", {
		cwd = false,
		subdirectory = true,
		parent = true,
		other = true,
		icon = "󱉭 ",
		color = function()
			return { fg = require("snacks").util.color("Special") }
		end,
	}, opts or {})

	local function get()
		local cwd = root_cwd()
		local root = root_get()
		local name = vim.fs.basename(root)

		if root == cwd then
			return opts.cwd and name
		end
		if root:find(cwd, 1, true) == 1 then
			return opts.subdirectory and name
		end
		if cwd:find(root, 1, true) == 1 then
			return opts.parent and name
		end
		return opts.other and name
	end

	return {
		function()
			return (opts.icon and opts.icon .. " ") .. get()
		end,
		cond = function()
			return type(get()) == "string"
		end,
		color = opts.color,
	}
end

local function safe_require(name)
	local ok, mod = pcall(require, name)
	if not ok then
		return nil
	end
	return mod
end

local function lazy_status()
	return safe_require("lazy.status")
end

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = vim.o.laststatus == 3,
		disabled_filetypes = {
			statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },

		lualine_c = {
			root_dir(),
			{
				"diagnostics",
				symbols = {
					error = icons.diagnostics.Error,
					warn = icons.diagnostics.Warn,
					info = icons.diagnostics.Info,
					hint = icons.diagnostics.Hint,
				},
			},
			{
				"filetype",
				icon_only = true,
				separator = "",
				padding = { left = 1, right = 0 },
			},
			pretty_path(),
		},
		lualine_x = {
			{
				function()
					return require("noice").api.status.command.get()
				end,
				cond = function()
					return package.loaded["noice"]
						and require("noice").api.status.command.has()
				end,
				color = function()
					return { fg = require("snacks").util.color("Statement") }
				end,
			},
			{
				function()
					return require("noice").api.status.mode.get()
				end,
				cond = function()
					return package.loaded["noice"]
						and require("noice").api.status.mode.has()
				end,
				color = function()
					return { fg = require("snacks").util.color("Constant") }
				end,
			},
			{
				function()
					return "  " .. require("dap").status()
				end,
				cond = function()
					return package.loaded["dap"] and require("dap").status() ~= ""
				end,
				color = function()
					return { fg = require("snacks").util.color("Debug") }
				end,
			},
			{
				function()
					local ls = lazy_status()
					if not ls then
						return ""
					end
					return ls.updates()
				end,
				cond = function()
					local ls = lazy_status()
					return ls ~= nil and ls.has_updates()
				end,
				color = function()
					return { fg = require("snacks").util.color("Special") }
				end,
			},
			{
				"diff",
				symbols = {
					added = icons.git.added,
					modified = icons.git.modified,
					removed = icons.git.removed,
				},
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return {
							added = gitsigns.added,
							modified = gitsigns.changed,
							removed = gitsigns.removed,
						}
					end
				end,
			},
		},
		lualine_y = {
			{ "progress", separator = " ", padding = { left = 1, right = 0 } },
			{ "location", padding = { left = 0, right = 1 } },
		},
		lualine_z = {
			function()
				return " " .. os.date("%R")
			end,
		},
	},
	extensions = { "neo-tree", "lazy", "fzf" },
})
