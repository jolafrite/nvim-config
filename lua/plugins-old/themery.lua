return {
	{
		'zaldih/themery.nvim',
		cmd = 'Themery',
		config = function()
			local status_ok, themery = pcall(require, 'themery')
			if not status_ok then
				return
			end

			themery.setup({
				themes = {
					{
						name = 'Catppuccin',
						colorscheme = 'catppuccin',
					},
					{
						name = 'Catppuccin Latte',
						colorscheme = 'catppuccin-latte',
					},
					{
						name = 'Catppuccin Frappe',
						colorscheme = 'catppuccin-frappe',
					},
					{
						name = 'Catppuccin Macchiato',
						colorscheme = 'catppuccin-macchiato',
					},
					{
						name = 'Catppuccin Mocha',
						colorscheme = 'catppuccin-mocha',
					},
				},
				themeConfigFile = '~/.config/nvim/lua/core/colorscheme.lua',
				livePreview = true,
			})
		end
	}
}
