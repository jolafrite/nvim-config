-- Vue `<script lang="ts">` blocks are injected TypeScript. typescript.lua now
-- only loads on JS/TS buffers (lazy), so install the TS parsers here too —
-- otherwise script highlighting silently disappears when only .vue files open.
PackageManager.add({
  name = 'lang.vue',
  filetype = { 'vue' },
  config = function()

require('utils').install_with_mason {
  'vue-language-server',
}

vim.lsp.config('vue_ls', {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_markers = { 'vue.config.js', '.git' },
})

local TS = require 'nvim-treesitter'
-- 'css' covers `<style>`; the TS trio covers `<script lang="ts">` blocks (same set typescript.lua installs).
pcall(TS.install, { 'vue', 'css', 'typescript', 'tsx', 'javascript' })

vim.lsp.enable 'vue_ls'
  end,
})

-- vim: ts=2 sts=2 sw=2 et
