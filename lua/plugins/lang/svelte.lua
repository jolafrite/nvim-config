
require('utils').install_with_mason {
  'svelte-language-server',
  'prettierd',
  'oxlint',
}

vim.lsp.config('svelte', {
  cmd = function(_, config)
    local cmd = 'svelteserver'
    if config and config.root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
    end
    return vim.lsp.rpc.start({ cmd, '--stdio' }, _)
  end,
  filetypes = { 'svelte' },
})

local conform = require 'conform'
conform.formatters_by_ft.svelte = { 'prettierd' }

require('lint').linters_by_ft.svelte = { 'oxlint' }

local TS = require 'nvim-treesitter'
pcall(TS.install, { 'svelte' })

vim.lsp.enable 'svelte'

