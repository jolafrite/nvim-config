return {
  {
    'nvim-lualine/lualine.nvim',
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    init = function()
      -- disable until lualine loads
      vim.opt.laststatus = 0
    end,
    config = function()
      local status_ok, lualine = pcall(require, 'lualine')
      if not status_ok then
        return
      end

      lualine.setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          lualine_a = {
            {
              'filename',
              path = 1,
            },
          },
        },
      })
    end
  }
}
