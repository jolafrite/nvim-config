return {
  'GustavoKatel/sidebar.nvim',
  cmd = { 'SidebarNvimToggle' },
  config = function()
    require('plugins/configs/sidebar_nvim')
  end,
}
