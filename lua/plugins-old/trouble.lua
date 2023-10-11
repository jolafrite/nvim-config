return {
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        close = "q", -- close the list
        close_folds = { "zM", "zm" }, -- close all folds
        help = "?", -- help menu
        hover = "K", -- opens a small popup with the full multiline message
        jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        next = "j", -- next item
        open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
        open_folds = { "zR", "zr" }, -- open all folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_tab = { "<c-t>" }, -- open buffer in new tab
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        preview = "p", -- preview the diagnostic location
        previous = "k", -- previous item
        refresh = "r", -- manually refresh
        switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
      },
      auto_close = false, -- automatically close the list when you have no diagnostics
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      cycle_results = true, -- cycle item list when reaching beginning or end of list
      fold_closed = "", -- icon used for closed folds
      fold_open = "", -- icon used for open folds
      group = true, -- group results by file
      height = 10, -- height of the trouble list when position is top or bottom
      icons = true, -- use devicons for filenames
      include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
      indent_lines = true, -- add an indent guide below the fold icons
      mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      multiline = true, -- render multi-line messages
      padding = false, -- add an extra new line on top of the list
      position = "bottom", -- position of the list can be: bottom, top, left, right
      severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
      signs = {
        -- icons / text used for a diagnostic
        error = "",
        hint = "",
        information = "",
        other = "",
        warning = "",
      },
      use_diagnostic_signs = true,        -- enabling this will use the signs defined in your lsp client
      width = 50,                         -- width of the list when position is left or right
      win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
    },
    config = function()
      vim.keymap.set('n', ';t', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })

      require("trouble").setup({})
    end
  }
}
