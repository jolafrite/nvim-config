return function()
    require("Comment").setup({
		-- Function to call before (un)comment
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	})
end
