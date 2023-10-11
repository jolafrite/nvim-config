-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/code-biscuits/nvim-biscuits
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  {
    "code-biscuits/nvim-biscuits",
    event = "LspAttach",
    config = function()
      local present, biscuits = pcall(require, "nvim-biscuits")

      --[[ if not present then
        return
      end ]]

      biscuits.setup {
        show_on_start = false,
        cursor_line_only = true,
        default_config = {
          min_distance = 10,
          max_length = 50,
          prefix_string = " 󰆘 ",
          prefix_highlight = "Comment",
          enable_linehl = true,
        },
      }
    end,
  },
}
