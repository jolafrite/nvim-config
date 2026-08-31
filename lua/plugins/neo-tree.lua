local gh = require("utils").gh

-- File tree. Only needed when the user opens it, so load on first FileType
-- rather than at startup.
PackageManager.add({
  [1] = gh("nvim-neo-tree/neo-tree.nvim"),
  event = "FileType",
  config = function()
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end

    require("neo-tree").setup({
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = {
        "terminal",
        "Trouble",
        "trouble",
        "qf",
        "Outline",
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              vim.ui.open(state.tree:get_node().path)
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
      event_handlers = {
        { event = require("neo-tree.events").FILE_MOVED, handler = on_move },
        { event = require("neo-tree.events").FILE_RENAMED, handler = on_move },
      },
    })

    -- Upstream bug (neo-tree + nui): follow_internal checks window_exists via
    -- state.bufnr but then calls state.tree:get_node(), which reads the cursor
    -- from the nui tree buffer's window. When that buffer has no window (stale
    -- state after a close/reopen) nui's get_winid() returns nil and
    -- nvim_win_get_cursor throws "Invalid 'win': Expected Lua number".
    local renderer = require("neo-tree.ui.renderer")
    local window_exists = renderer.window_exists
    renderer.window_exists = function(state, ...)
      if not window_exists(state, ...) then
        return false
      end
      local tree = state.tree
      return not tree or vim.fn.bufwinid(tree.bufnr) ~= -1
    end
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*lazygit",
  callback = function()
    if package.loaded["neo-tree.sources.git_status"] then
      require("neo-tree.sources.git_status").refresh()
    end
  end,
})

vim.keymap.set("n", "<leader>e", function()
  require("neo-tree.command").execute({ toggle = true, reveal = true })
end, { desc = "Toggle Neo-tree" })
