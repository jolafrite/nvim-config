-- No example configuration was found for this plugin.
--
-- For detailed information on configuring this plugin, please refer to its
-- official documentation:
--
--   https://github.com/nvim-telescope/telescope.nvim
--
-- If you wish to use this plugin, you can optionally modify and then uncomment
-- the configuration below.
local databases_dir = require('core.global').databases_dir

return {
  'nvim-telescope/telescope.nvim',
  event = { 'VimEnter' },
  cmd = 'Telescope',
  build = function()
    os.execute('mkdir -p ' .. databases_dir)
  end,
  dependencies = {
    {
      'prochri/telescope-all-recent.nvim',
      config = true,
    },
    { 'nvim-telescope/telescope-github.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'LinArcX/telescope-changes.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
    { 'nvim-telescope/telescope-smart-history.nvim' },
    { 'nvim-telescope/telescope-symbols.nvim' },
    { 'debugloop/telescope-undo.nvim' },
    { 'nvim-telescope/telescope-frecency.nvim' },
    { 'crispgm/telescope-heading.nvim' },
  },
  config = function()
    require('plugins/configs/telescope_nvim')
  end,
}
