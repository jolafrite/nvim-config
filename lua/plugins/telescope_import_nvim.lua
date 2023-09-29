-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/piersolenski/telescope-import.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  "piersolenski/telescope-import.nvim",
  requires = 'nvim-telescope/telescope.nvim',
  config = function()
    local telescope = require("telescope")

    telescope.load_extension("import")

    telescope.setup({
      import = {
        insert_at_top = true,
      }
    })
  end
}
