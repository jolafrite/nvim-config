local gh = require('utils').gh

-- Markdown rendering (headings, code blocks, checkboxes). Only useful on
-- markdown buffers, so load on first FileType match rather than at startup.
Manager.add {
  [1] = gh 'MeanderingProgrammer/render-markdown.nvim',
  filetype = 'markdown',
  config = function()
    require('render-markdown').setup {
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
