return {
  {
    'akinsho/toggleterm.nvim',
    lazy = true,
    event = 'VimEnter',
    cmd = {
      "ToggleTerm",
      "ToggleTermSetName",
      "ToggleTermToggleAll",
      "ToggleTermSendVisualLines",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualSelection",
    },
    config = function()
      local status_ok, toggleterm = pcall(require, 'toggleterm')

      if not status_ok then
        return
      end

      toggleterm.setup({
        size = 13,
        open_mapping = [[<c-\>]],
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = '1',
        start_in_insert = true,
        persist_size = true,
        direction = 'horizontal',
      })
    end
  }
}
