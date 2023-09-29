return {
  'akinsho/bufferline.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  lazy = true,
  event = { "BufReadPost", "BufAdd", "BufNewFile" },
  config = function()
    vim.opt.termguicolors = true

    require('bufferline').setup({
      options = {
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'NvimTree',
            highlight = 'Directory',
            text_align = 'center'
          }
        },
        separator_style = 'slant',
        hover = {
          enabled = true,
          delay = 0,
          reveal = { 'close' }
        },
        indicator = {
          style = 'icon'
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diagnostics_dict, context)
          local s = " "

          if context.buffer:current() then
            return s
          end

          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " "
                or (e == "warning" and " " or "")
            s = s .. n .. sym
          end

          return s
        end
      }
    })
  end
}
