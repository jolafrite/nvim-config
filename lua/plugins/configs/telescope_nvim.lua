local databases_dir = require('core.global').databases_dir
local icons = { ui = require('plugins.utils.icons').get('ui', true) }
local telescope = require('telescope')

telescope.load_extension('gh')
telescope.load_extension('ui-select')
telescope.load_extension('changes')
telescope.load_extension('live_grep_args')
telescope.load_extension('fzf')
telescope.load_extension('smart_history')
telescope.load_extension('undo')
telescope.load_extension('frecency')
telescope.load_extension('heading')

telescope.setup({
  defaults = {
    prompt_prefix = ' ' .. icons.ui.Telescope .. ' ',
    selection_caret = icons.ui.ChevronRight,
    limit = 'limit',
    results_title = false,
    path_display = { 'truncate' },
    file_ignore_patterns = { '.git/', '.cache', '%.class', '%.pdf', '%.mkv', '%.mp4', '%.zip', 'node_modules/' },
    history = {
      path = databases_dir .. '/telescope_history.sqlite3',
      limit = 100,
    },
  },
  pickers = {
    find_files = {
      theme = 'dropdown',
      previewer = false,
    },
    oldfiles = {
      theme = 'dropdown',
      previewer = false,
    },
  },
  extensions = {
    frecency = {
      db_root = databases_dir,
      ignore_patterns = { '*.git/*', '*/tmp/*', '*/node_modules/*' },
      show_scores = true,
      show_unindexed = true,
      db_safe_mode = false,
      auto_validate = true,
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    heading = {
      treesitter = true,
    },
    live_grep_args = {
      auto_quoting = true,
    },
  },
})
