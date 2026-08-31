-- Svelte `<script>` blocks are injected TypeScript. typescript.lua now only
-- loads on JS/TS buffers (lazy), so install the TS parsers here too — otherwise
-- script highlighting silently disappears when only .svelte files open.
PackageManager.add({
  name = 'lang.svelte',
  filetype = { 'svelte' },
  config = function()

require('utils').install_with_mason {
  'svelte-language-server',
  'prettier',
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
conform.formatters.prettier = {
  command = 'prettier',
  stdin = true,
}
conform.formatters_by_ft.svelte = { 'prettier' }

require('lint').linters_by_ft.svelte = { 'oxlint' }

local TS = require 'nvim-treesitter'
-- 'css' covers `<style>`; the TS trio covers `<script>` blocks (same set typescript.lua installs).
pcall(TS.install, { 'svelte', 'css', 'typescript', 'tsx', 'javascript' })

vim.lsp.enable 'svelte'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
