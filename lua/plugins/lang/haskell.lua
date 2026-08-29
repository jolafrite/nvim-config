-- Haskell language support (haskell-tools + treesitter + LSP config).
--
-- haskell-tools manages the haskell-language-server lifecycle itself, so no
-- `vim.lsp.config`/`vim.lsp.enable` is needed here; lspconfig must NOT start
-- a second HLS client either.
local gh = require('utils').gh

vim.pack.add {
  gh 'mrcjkb/haskell-tools.nvim',
}

require('utils').install_with_mason {
  'haskell-language-server',
  'haskell-debug-adapter',
  'fourmolu',
  'hlint',
}

-- Tree-sitter parsers for Haskell/Cabal.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'haskell', 'cabal' })

local conform = require 'conform'
conform.formatters_by_ft.haskell = { 'fourmolu' }
conform.formatters_by_ft.cabal = { 'cabal_fmt' }

local lint = require 'lint'
lint.linters_by_ft.haskell = { 'hlint' }

require('utils').on_file_types({ 'haskell', 'lhaskell' }, function()
  local ok, ht = pcall(require, 'haskell-tools')
  if ok then
    ht.setup {
      hls = {
        on_attach = function(_, bufnr)
          vim.keymap.set('n', '<localleader>e', '<cmd>HlsEvalAll<cr>', { buffer = bufnr, desc = 'Evaluate All' })
          vim.keymap.set(
            'n',
            '<localleader>h',
            function() require('haskell-tools').hoogle.hoogle_signature() end,
            { buffer = bufnr, desc = 'Hoogle Signature' }
          )
          vim.keymap.set('n', '<localleader>r', function() require('haskell-tools').repl.toggle() end, { buffer = bufnr, desc = 'REPL (Package)' })
          vim.keymap.set(
            'n',
            '<localleader>R',
            function() require('haskell-tools').repl.toggle(vim.api.nvim_buf_get_name(0)) end,
            { buffer = bufnr, desc = 'REPL (Buffer)' }
          )
        end,
      },
    }
  end
end)

-- vim: ts=2 sts=2 sw=2 et
