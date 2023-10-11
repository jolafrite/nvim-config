return {
  'roobert/activate.nvim',
  lazy = false,
  cmd = { 'PluginsInstall' },
  keys = {
    {
      '<leader>P',
      ':lua require("activate").list_plugins()<CR>',
      desc = 'Plugins',
    },
  },
}
