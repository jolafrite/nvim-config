local gh = require('utils').gh

-- File tree. Only needed when the user opens it, so load on first FileType
-- rather than at startup.
require('utils').on_file_types('*', function()
  vim.pack.add {
    gh 'nvim-neo-tree/neo-tree.nvim',
  }

  local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end

  require('neo-tree').setup {
    sources = { 'filesystem', 'buffers', 'git_status' },
    open_files_do_not_replace_types = {
      'terminal',
      'Trouble',
      'trouble',
      'qf',
      'Outline',
    },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<space>'] = 'none',
        ['Y'] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg('+', path, 'c')
          end,
          desc = 'Copy Path to Clipboard',
        },
        ['O'] = {
          function(state) vim.ui.open(state.tree:get_node().path) end,
          desc = 'Open with System Application',
        },
        ['P'] = { 'toggle_preview', config = { use_float = false } },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      git_status = {
        symbols = {
          unstaged = '󰄱',
          staged = '󰱒',
        },
      },
    },
    event_handlers = {
      { event = require('neo-tree.events').FILE_MOVED, handler = on_move },
      { event = require('neo-tree.events').FILE_RENAMED, handler = on_move },
    },
  }
end)

vim.api.nvim_create_autocmd('TermClose', {
  pattern = '*lazygit',
  callback = function()
    if package.loaded['neo-tree.sources.git_status'] then require('neo-tree.sources.git_status').refresh() end
  end,
})

vim.keymap.set('n', '<leader>e', function() require('neo-tree.command').execute { toggle = true, reveal = true } end, { desc = 'Toggle Neo-tree' })
