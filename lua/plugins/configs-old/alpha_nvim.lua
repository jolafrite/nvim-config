return function()
	local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.opts.hl = "Question"

	dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.buttons.val = {
		dashboard.button("s", "  Open last session", ":PossessionLoadCurrent<CR>"),
		dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
		dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("f", "󰈞  Find file", ":Telescope find_files hidden=true no_ignore=true <CR>"),
		dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
		dashboard.button("t", "󰉿  Find text", ":Telescope live_grep <CR>"),
		dashboard.button("b", "  Jump to bookmarks", ":Telescope marks<CR>"),
		dashboard.button("p", "  Install plugins", ":lua require('activate').list_plugins()<CR>"),
		dashboard.button("p", "  Update plugins", ":Lazy sync<CR>"),
		dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
	}
    dashboard.section.footer.opts.hl = "Type"
	dashboard.section.footer.val = "Total plugins: " .. require("lazy").stats().count

	dashboard.opts.opts.noautocmd = true

	alpha.setup(dashboard.opts)
end
