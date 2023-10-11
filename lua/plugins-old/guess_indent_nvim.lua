-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/NMAC427/guess-indent.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.

return {
  {
    "nmac427/guess-indent.nvim",
    event = "VeryLazy",
    config = function()
      require("guess-indent").setup({
        auto_cmd = true,         -- Set to false to disable automatic execution
        override_editorconfig = false, -- Set to true to override settings set by .editorconfig
        filetype_exclude = {     -- A list of filetypes for which the auto command gets disabled
          "netrw",
          "tutor",
        },
        buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
          "help",
          "nofile",
          "terminal",
          "prompt",
        },
      })
    end,
  }
}

