local icons = {
  ui = require('plugins.utils.icons').get('ui'),
  diagnostics = require('plugins.utils.icons').get('diagnostics'),
}
local bufferline = require('bufferline')

bufferline.setup({
  options = {
    modified_icon = icons.ui.Modified,
    buffer_close_icon = icons.ui.Close,
    left_trunc_marker = icons.ui.Left,
    right_trunc_marker = icons.ui.Right,
    color_icons = true,
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(_, _, diagnostics_dict, context)
      if context.buffer:current() then
        return ''
      end

      local s = ' '

      for e, n in pairs(diagnostics_dict) do
        local sym = e == 'error' and icons.diagnostics.Error_alt
          or (e == 'warning' and icons.diagnostics.Warning_alt or icons.diagnostics.Information_alt)
        s = s .. sym .. n
      end

      return s
    end,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    enforce_regular_tabs = true,
    persist_buffer_sort = true,
    always_show_bufferline = true,
    separator_style = 'slant',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'center',
        padding = 1,
      },
      {
        filetype = 'lspsagaoutline',
        text = 'Lspsaga Outline',
        text_align = 'center',
        padding = 1,
      },
    },
    custom_areas = {
      right = function()
        local result = {}
        local seve = vim.diagnostic.severity
        local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
        local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
        local info = #vim.diagnostic.get(0, { severity = seve.INFO })
        local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

        if error ~= 0 then
          table.insert(result, { text = ' ' .. icons.diagnostics.Error_alt .. ' ' .. error, fg = '#A3BA5E' })
        end

        if warning ~= 0 then
          table.insert(result, { text = ' ' .. icons.diagnostics.Warning_alt .. ' ' .. warning, fg = '#A3BA5E' })
        end

        if hint ~= 0 then
          table.insert(result, { text = ' ' .. icons.diagnostics.Hint_alt .. ' ' .. hint, fg = '#A3BA5E' })
        end

        if info ~= 0 then
          table.insert(result, { text = ' ' .. icons.diagnostics.Information_alt .. ' ' .. hint, fg = '#7EA9A7' })
        end

        return result
      end,
    },
  },
  -- Change bufferline's highlights here! See `:h bufferline-highlights` for detailed explanation.
  -- Note: If you use catppuccin then modify the colors below!
  -- highlights = {},
})
