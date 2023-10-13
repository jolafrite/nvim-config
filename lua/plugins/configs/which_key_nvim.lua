local which_key = require('which-key')

which_key.setup({
  layout = {
    align = 'center', -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
})

local mappings = {
  ['a'] = { ':Alpha<Cr>', 'Dashboard' },
  ['R'] = { ':%d+<Cr>', 'Remove All Text' },
  ['y'] = { ':%y+<Cr>', 'Yank All Text' },

  e = {
    name = 'Tree Explorer',
    t = { ':NvimTreeToggle<Cr>', 'Toggle' },
    f = { ':NvimTreeOpen:NvimTreeToggle<Cr>', 'Focus' },
  },

  b = {
    name = 'Buffer',
    p = { ':bprevious<Cr>', 'Previous buffer' },
    n = { ':bnext<Cr>', 'Next buffer' },
    k = { ':BufDel<Cr>', 'Kill current buffer' },
    K = { ':BufDelOthers<Cr>', 'Kill all buffers except current' },
    b = { ':Telescope buffers<Cr>', 'Buffer List' },
  },

  p = {
    name = 'Package Manager',
    x = { ':Lazy clean<Cr>', 'Clean' },
    C = { ':Lazy check<Cr>', 'Check' },
    d = { ':Lazy debug<Cr>', 'Debug' },
    i = { ':Lazy install<Cr>', 'Install' },
    s = { ':Lazy sync<Cr>', 'Sync' },
    l = { ':Lazy log<Cr>', 'Log' },
    h = { ':Lazy home<Cr>', 'Home' },
    H = { ':Lazy help<Cr>', 'Help' },
    p = { ':Lazy profile<Cr>', 'Profile' },
    u = { ':Lazy update<Cr>', 'Update' },
  },

  f = {
    name = 'Find',
    a = { ':Telescope autocommands<Cr>', 'Autocommmands' },
    c = { ':Telescope colorscheme<Cr>', 'Colorschemes' },
    f = {
      ':Telescope find_files hidden=true no_ignore=true<Cr>',
      'Files',
    },
    p = { ':Telescope projects <Cr>', 'Projects' },
    b = { ':Telescope buffers<Cr>', 'Buffers' },
    h = { ':Telescope help_tags<Cr>', 'Help' },
    r = { ':Telescope oldfiles<Cr>', 'Recent Files' },
    k = { ':Telescope keymaps<Cr>', 'Keymaps' },
    C = { ':Telescope commands<Cr>', 'Commands' },
    d = { ':Telescope diagnostics<Cr>', 'Diagnostics' },
  },

  c = {
    name = 'Code',
    R = { ':Lspsaga rename ++project<Cr>', 'Rename in Project' },
    X = { ':TroubleToggle document_diagnostics<Cr>', 'Current buffer Diagnostics' },
    a = { ':Lspsaga code_action<Cr>', 'Code Action' },
    e = { ':Jaq<Cr>', 'Execute Code' },
    f = { ":lua require 'conform'.format({ lsp_fallback = true, async = false, timeout_ms = 1000, })<Cr>", 'Format' },
    l = { ':lua require "lint".try_lint()<Cr>', 'Lint' },
    n = { ':Lspsaga diagnostic_jump_next<Cr>', 'Next Diagnostic' },
    o = { ':Lspsaga outline<Cr>', 'Code Outline' },
    p = { ':Lspsaga diagnostic_jump_prev<Cr>', 'Prev Diagnostic' },
    r = { ':Lspsaga rename<Cr>', 'Rename in current buffer' },
    x = { ':TroubleToggle workspace_diagnostics<Cr>', 'Workspace Diagnostics' },
  },

  n = {
    name = 'Package Info',
    s = { ":lua require 'package-info'.show()<Cr>", 'Show dependency versions' },
    c = { ":lua require 'package-info'.hide()<Cr>", 'Show dependency versions' },
    t = { ":lua require 'package-info'.toggle()<Cr>", 'Toggle dependency versions' },
    u = { ":lua require 'package-info'.update()<Cr>", 'Update dependency version on the line' },
    d = { ":lua require 'package-info'.delete()<Cr>", 'Delete dependency version on the line' },
    i = { ":lua require 'package-info'.install()<Cr>", 'Install new dependency version' },
    p = { ":lua require 'package-info'.change_version()<Cr>", 'Install a different dependency version' },
  },

  r = {
    name = 'Replace',
    r = { ":lua require('spectre').open()<Cr>", 'Replace in path' },
    w = { ":lua require('spectre').open_visual({select_word=true})<Cr>", 'Replace Word' },
    b = { ":lua require('spectre').open_file_search()<Cr>", 'Replace in the current Buffer' },
  },

  j = {
    name = 'Java',
    t = {
      ":lua require'jdtls'.test_nearest_method({ config = { console = 'console' }})<Cr>",
      'Test Method (without Maven)',
    },
    T = {
      ":lua require'jdtls'.test_class({ config = { console = 'console' }})<Cr>",
      'Test Class (without Maven)',
    },
    u = { ':JdtUpdateConfig<Cr>', 'Update Config' },
    d = { ':JdtRefreshDebugConfigs<Cr>', 'Refresh debug config' },
    r = { ':Jaq<Cr>', 'Execute Java' },
    R = { ':JdtWipeDataAndRestart<Cr>', 'Wipe project data and Restart server' },
    x = { ':JdtRestart<Cr>', 'Restart server' },
    v = { ':JdtSetRuntime<Cr>', 'Set runtime' },
    s = {
      ":lua require('jdtls').setup_dap({ hotcodereplace = 'auto' })<Cr>; :lua require'jdtls.dap'.setup_dap_main_class_configs()<Cr>",
      'Setup DAP Debugger',
    },
  },

  s = {
    name = 'Search String',
    b = { ':Telescope current_buffer_fuzzy_find<Cr>', 'In current Buffer' },
    p = { ':Telescope live_grep_args theme=ivy<Cr>', 'In Project' },
    l = { ':Telescope resume<Cr>', 'Last Search' },
  },

  g = {
    name = 'Git',
    g = { ':LazyGit<Cr>', 'Lazygit' },
    G = { ':Git<Cr>', 'Git Fugitive' },
    n = { ":lua require 'gitsigns'.next_hunk()<Cr>", 'Next Hunk' },
    p = { ":lua require 'gitsigns'.prev_hunk()<Cr>", 'Prev Hunk' },
    l = { ":lua require 'gitsigns'.blame_line()<Cr>", 'Blame' },
    P = { ":lua require 'gitsigns'.preview_hunk()<Cr>", 'Preview Hunk' },
    r = { ":lua require 'gitsigns'.reset_hunk()<Cr>", 'Reset Hunk' },
    R = { ":lua require 'gitsigns'.reset_buffer()<Cr>", 'Reset Buffer' },
    s = { ":lua require 'gitsigns'.stage_hunk()<Cr>", 'Stage Hunk' },
    u = {
      ":lua require 'gitsigns'.undo_stage_hunk()<Cr>",
      'Undo Stage Hunk',
    },
    o = { ':Telescope git_status<Cr>', 'Open changed file' },
    b = { ':Telescope git_branches<Cr>', 'Checkout branch' },
    c = { ':Telescope git_commits<Cr>', 'Checkout commit' },
    d = {
      ':DiffviewOpen<Cr>',
      'Open Diff',
    },
    D = {
      ':DiffviewClose<Cr>',
      'Close Diff',
    },
  },

  l = {
    name = 'LSP - Language',
    f = { ':lua vim.lsp.buf.format({ async = true })<Cr>', 'Format' },
    i = { ':LspInfo<Cr>', 'Info' },
    m = { ':Mason<Cr>', 'Install Language' },
  },

  d = {
    name = 'Debug',
    c = { ":lua require 'dap'.continue()<Cr>", 'Start/Continue' },
    o = { ":lua require 'dap'.step_over()<Cr>", 'Step Over' },
    i = { ":lua require 'dap'.step_into()<Cr>", 'Step Into' },
    u = { ":lua require 'dap'.step_out()<Cr>", 'Step Out' },
    b = { ":lua require 'dap'.toggle_breakpoint()<Cr>", 'Breakpoint' },
    r = { ":lua require 'dap'.repl.open()<Cr>", 'Repl Console' },
    d = { ":lua require 'dapui'.toggle()<Cr>", 'Dap UI' },
    t = { ":lua require 'dap'.terminate()<Cr>", 'Terminate session' },
  },

  o = {
    name = 'Open',
    f = { ':ToggleTerm direction=float<Cr>', 'Float Terminal' },
    t = { ':ToggleTerm size=16 direction=horizontal<Cr>', 'Horizontal Terminal' },
    v = { ':ToggleTerm size=50 direction=vertical<Cr>', 'Vertical Terminal' },
  },

  t = {
    name = 'Toggle',
    w = { ":lua require 'plugins.utils.functions'.toggle_option('wrap')<Cr>", 'Wrap Text' },
    r = {
      ":lua require 'plugins.utils.functions'.toggle_option('relativenumber')<Cr>",
      'Relative Code Line Numbers',
    },
    a = {
      ':lua require("plugins.utils.functions").toggle_option("number")<Cr>',
      'Absolute Code Line Numbers',
    },
    s = { ':FormatToggle<Cr>', 'Auto format on save' },
    c = { ":let &cole=(&cole == 2) ? 0 : 2 <bar> echo 'conceallevel ' . &cole <Cr>", 'ConcealLevel' },
  },

  w = {
    name = 'Window',
    w = { '<C-w>w', 'Last window' },
    q = { ':q!<Cr>', 'Kill window' },
  },
}

which_key.register(mappings, {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
})
