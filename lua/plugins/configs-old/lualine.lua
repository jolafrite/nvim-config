return function()
  local colors = require('plugins.utils').get_palette()
  local icons = {
    diagnostics = require('plugins.utils.icons').get('diagnostics', true),
    misc = require('plugins.utils.icons').get('misc', true),
    ui = require('plugins.utils.icons').get('ui', true),
  }

  local status_ok, lualine = pcall(require, 'lualine')
  if not status_ok then
    return
  end

  local _cache = { context = '', bufnr = -1 }
  local function lspsaga_symbols()
    local exclude = {
      ['terminal'] = true,
      ['toggleterm'] = true,
      ['prompt'] = true,
      ['NvimTree'] = true,
      ['help'] = true,
    }
    if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
      return '' -- Excluded filetypes
    else
      local currbuf = vim.api.nvim_get_current_buf()
      local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
      if ok and lspsaga:get_winbar() ~= nil then
        _cache.context = lspsaga:get_winbar()
        _cache.bufnr = currbuf
      elseif _cache.bufnr ~= currbuf then
        _cache.context = '' -- Reset [invalid] cache (usually from another buffer)
      end

      return _cache.context
    end
  end

  local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end

  local function escape_status()
    local ok, m = pcall(require, 'better_escape')
    return ok and m.waiting and icons.misc.EscapeST or ''
  end

  local function get_cwd()
    local cwd = vim.fn.getcwd()
    local is_windows = require('core.global').is_windows
    if not is_windows then
      local home = require('core.global').home
      if cwd:find(home, 1, true) == 1 then
        cwd = '~' .. cwd:sub(#home + 1)
      end
    end
    return icons.ui.RootFolderOpened .. cwd
  end

  lualine.setup({
    options = {
      icons_enabled = true,
      theme = 'auto',
      disabled_filetypes = {},
      component_separators = '|',
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { { 'branch' } },
      lualine_b = { { 'diff', source = diff_source } },
      lualine_c = { lspsaga_symbols },
      lualine_x = {
        { escape_status },
        {
          'diagnostics',
          sources = { 'nvim_workspace_diagnostic' },
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warning,
            info = icons.diagnostics.Information,
          },
        },
        { get_cwd },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {
      'quickfix',
      'nvim-tree',
      'nvim-dap-ui',
      'toggleterm',
      'fugitive',
      'outline',
      'diffview',
    },
  })

  -- Properly set background color for lspsaga
  -- local winbar_bg = require("plugins.utils").hl_to_rgb("StatusLine", true, colors.mantle)
  -- for _, hlGroup in pairs(require("lspsaga.lspkind").get_kind_group()) do
  --     require("plugins.utils").extend_hl(hlGroup, { bg = winbar_bg })
  -- end
end
