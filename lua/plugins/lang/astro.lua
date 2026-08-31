-- Astro's `<script>` blocks and `{expr}` are injected TypeScript. typescript.lua
-- now only loads on JS/TS buffers (lazy), so install the TS parsers here too —
-- otherwise script highlighting silently disappears when only .astro files open.
PackageManager.add({
  name = 'lang.astro',
  filetype = { 'astro' },
  config = function()

require('utils').install_with_mason {
  'astro-language-server',
}

vim.lsp.config('astro', {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'astro.config.js', 'astro.config.mjs', 'astro.config.cjs', 'astro.config.ts', '.git' },
})

local conform = require 'conform'
conform.formatters_by_ft.astro = { 'prettier' }

local TS = require 'nvim-treesitter'
-- 'css' covers `<style>`; the TS trio covers `<script>`/`{expr}` blocks (same set typescript.lua installs).
pcall(TS.install, { 'astro', 'css', 'typescript', 'tsx', 'javascript' })

vim.lsp.enable 'astro'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
