local gh = require('utils').gh

-- Better yank/paste with ring history. Needs a real buffer, so load on first
-- BufReadPost rather than at startup.
Manager.add {
  [1] = gh 'gbprod/yanky.nvim',
  event = 'BufReadPost',
  config = function()
    local Yanky = require 'yanky'
    Yanky.setup {
      system_clipboard = {
        sync_with_ring = not vim.env.SSH_CONNECTION,
      },
      highlight = {
        timer = 150,
      },
    }
  end,
}

local opts = { silent = true, desc = 'Open Yank History' }
vim.keymap.set({ 'n', 'x' }, '<leader>p', function()
  -- yanky registers a `yanky` picker source; Snacks.picker.yanky() is the
  -- entry point when it exists, otherwise fall back to the ring UI.
  if Snacks.picker.sources['yanky'] then
    Snacks.picker.yanky()
  else
    vim.cmd [[YankyRingHistory]]
  end
  return true
end, opts)

-- stylua: ignore
vim.keymap.set({ 'n', 'x' }, 'y', '<Plug>(YankyYank)', { desc = 'Yank Text' })
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put Text After Cursor' })
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put Text Before Cursor' })
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)', { desc = 'Put After Selection' })
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)', { desc = 'Put Before Selection' })
vim.keymap.set('n', '[y', '<Plug>(YankyCycleForward)', { desc = 'Cycle Forward Through Yank History' })
vim.keymap.set('n', ']y', '<Plug>(YankyCycleBackward)', { desc = 'Cycle Backward Through Yank History' })
vim.keymap.set('n', ']p', '<Plug>(YankyPutIndentAfterLinewise)', { desc = 'Put Indented After Cursor (Linewise)' })
vim.keymap.set('n', '[p', '<Plug>(YankyPutIndentBeforeLinewise)', { desc = 'Put Indented Before Cursor (Linewise)' })
vim.keymap.set('n', ']P', '<Plug>(YankyPutIndentAfterLinewise)', { desc = 'Put Indented After Cursor (Linewise)' })
vim.keymap.set('n', '[P', '<Plug>(YankyPutIndentBeforeLinewise)', { desc = 'Put Indented Before Cursor (Linewise)' })
vim.keymap.set('n', '>p', '<Plug>(YankyPutIndentAfterShiftRight)', { desc = 'Put and Indent Right' })
vim.keymap.set('n', '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', { desc = 'Put and Indent Left' })
vim.keymap.set('n', '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', { desc = 'Put Before and Indent Right' })
vim.keymap.set('n', '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', { desc = 'Put Before and Indent Left' })
vim.keymap.set('n', '=p', '<Plug>(YankyPutAfterFilter)', { desc = 'Put After Applying a Filter' })
vim.keymap.set('n', '=P', '<Plug>(YankyPutBeforeFilter)', { desc = 'Put Before Applying a Filter' })

-- vim: ts=2 sts=2 sw=2 et
