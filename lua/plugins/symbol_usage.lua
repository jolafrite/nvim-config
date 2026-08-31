local gh = require('utils').gh

-- Only useful once an LSP attaches, so load lazily instead of at startup.
Manager.add {
  [1] = gh 'Wansmer/symbol-usage.nvim',
  event = 'LspAttach',
  config = function()
    require('symbol-usage').setup {
      vt_position = 'end_of_line',
      text_format = function(symbol)
        if symbol.references then
          local usage = symbol.references <= 1 and 'usage' or 'usages'
          local num = symbol.references == 0 and 'no' or symbol.references
          return string.format(' 󰌹 %s %s', num, usage)
        else
          return ''
        end
      end,
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
