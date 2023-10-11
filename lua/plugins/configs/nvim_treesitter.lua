local use_ssh = require('core.settings').use_ssh

vim.api.nvim_set_option_value('foldmethod', 'expr', {})
vim.api.nvim_set_option_value('foldexpr', 'nvim_treesitter#foldexpr()', {})

require('nvim-treesitter.configs').setup({
  ensure_installed = require('core.settings').treesitter,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(ft, bufnr)
      if vim.tbl_contains({ 'vim' }, ft) then
        return true
      end

      local ok, is_large_file = pcall(vim.api.nvim_buf_get_var, bufnr, 'bigfile_disable_treesitter')
      return ok and is_large_file
    end,
    additional_vim_regex_highlighting = { 'c', 'cpp' },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  indent = {
    enable = false,
  },
  -- Extensions
  -- vim-match-up
  matchup = { enable = true },
  -- nvim-treesitter-refactor
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "'r",
      },
    },
    navigation = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
      keymaps = {
        goto_definition = "'d",
        list_definitions = "'D",
        list_definitions_toc = 'gO',
        goto_next_usage = '<a-*>',
        goto_previous_usage = '<a-#>',
      },
    },
  },
  -- nvim-tree-docs
  tree_docs = { enable = true },
  -- nvim-yati
  yati = {
    enable = true,
  },
})

require('nvim-treesitter.install').prefer_git = true

if use_ssh then
  local parsers = require('nvim-treesitter.parsers').get_parser_configs()
  for _, p in pairs(parsers) do
    p.install_info.url = p.install_info.url:gsub('https://github.com/', 'git@github.com:')
  end
end
