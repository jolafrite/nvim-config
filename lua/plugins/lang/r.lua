local gh = require('utils').gh

PackageManager.add({
  [1] = gh 'R-nvim/R.nvim',
  filetype = {'r', 'rmd', 'quarto'},
  config = function()

local r_opts = {
  R_args = { '--quiet', '--no-save' },
  hook = {
    on_filetype = function()
      vim.keymap.set('n', '<Enter>', '<Plug>RDSendLine', { buffer = true })
      vim.keymap.set('x', '<Enter>', '<Plug>RSendSelection', { buffer = true })

      local wk = require 'which-key'
      wk.add {
        buffer = true,
        mode = { 'n', 'x' },
        { '<localleader>a', group = 'all' },
        { '<localleader>b', group = 'between marks' },
        { '<localleader>c', group = 'chunks' },
        { '<localleader>f', group = 'functions' },
        { '<localleader>g', group = 'goto' },
        { '<localleader>i', group = 'install' },
        { '<localleader>k', group = 'knit' },
        { '<localleader>p', group = 'paragraph' },
        { '<localleader>q', group = 'quarto' },
        { '<localleader>r', group = 'r general' },
        { '<localleader>s', group = 'split or send' },
        { '<localleader>t', group = 'terminal' },
        { '<localleader>v', group = 'view' },
      }
    end,
  },
  pdfviewer = '',
}

require('utils').on_file_types({ 'r', 'rmd', 'quarto' }, function()
  vim.g.rout_follow_colorscheme = true
  local ok, r = pcall(require, 'r')
  if ok then
    r.setup(r_opts)
    pcall(function() require('r.pdf.generic').open = vim.ui.open end)
  end
  vim.lsp.enable 'r_language_server'
end)

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'r', 'rnoweb' })

pcall(function()
  require('neotest').setup {
    adapters = {
      ['neotest-testthat'] = {},
    },
  }
end)


  end,
})

