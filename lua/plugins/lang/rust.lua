-- Rust language support.
--
-- LSP is provided by rustaceanvim (which wraps rust-analyzer), so the
-- standalone rust_analyzer config below is intentionally empty -- it inherits
-- the base cmd/filetypes set in lsp.lua. The heavy settings (clippy on save,
-- proc-macro, file excludes) live in rustaceanvim's default_settings.
vim.lsp.config('rust_analyzer', {})
-- Tree-sitter parser for Rust.
local TS = require 'nvim-treesitter'
pcall(TS.install, { 'rust' })

local gh = require('utils').gh

vim.pack.add {
  gh 'mrcjkb/rustaceanvim',
  gh 'Saecki/crates.nvim',
}

require('utils').install_with_mason {
  'rust-analyzer',
  'codelldb',
}

local diagnostics = vim.g.lazyvim_rust_diagnostics or 'rust-analyzer'

-- bacon-ls provides diagnostics-only when `vim.g.lazyvim_rust_diagnostics`
-- is set to "bacon-ls" (rust-analyzer still provides the rest of the LSP).
if diagnostics == 'bacon-ls' then
  require('utils').install_with_mason {
    'bacon',
  }
  vim.lsp.config('bacon_ls', {
    cmd = { 'bacon-ls' },
    filetypes = { 'rust' },
  })
  vim.lsp.enable 'bacon_ls'
end

-- rustaceanvim does NOT expose a setup() function -- it auto-attaches the
-- rust-analyzer LSP client on FileType=rust via its ftplugin. Configuration
-- goes through vim.g.rustaceanvim (a table or function returning a table).
-- DAP: rustaceanvim auto-detects codelldb from PATH (installed via mason),
-- so no manual adapter wiring is needed here.
vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, {
  server = {
    on_attach = function(_, bufnr)
      vim.keymap.set('n', '<leader>cR', function() vim.cmd.RustLsp 'codeAction' end, { desc = 'Code Action', buffer = bufnr })
      vim.keymap.set('n', '<leader>dr', function() vim.cmd.RustLsp 'debuggables' end, { desc = 'Rust Debuggables', buffer = bufnr })
    end,
    default_settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = { enable = true },
        },
        -- Add clippy lints for Rust if using rust-analyzer
        checkOnSave = diagnostics == 'rust-analyzer',
        -- Enable diagnostics if using rust-analyzer
        diagnostics = { enable = diagnostics == 'rust-analyzer' },
        procMacro = { enable = true },
        files = {
          exclude = {
            '.direnv',
            '.git',
            '.jj',
            '.github',
            '.gitlab',
            'bin',
            'node_modules',
            'target',
            'venv',
            '.venv',
          },
          -- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
          watcher = 'client',
        },
      },
    },
  },
})

require('crates').setup()

require('conform').formatters_by_ft.rust = { 'rustfmt' }

require('conform').formatters.rustfmt = {
  command = 'rustfmt',
  stdin = true,
  args = { '--emit=stdout' },
}

require('lint').linters_by_ft.rust = { 'clippy' }

-- Overridden with ignore_exitcode=true: cargo clippy exits 101 when the code
-- doesn't compile, which is expected (can't lint uncompilable code). Without
-- the override nvim-lint reports "Linter command `cargo` exited with code: 101".
require('lint').linters.clippy = vim.tbl_deep_extend('force', require('lint').linters.clippy, { ignore_exitcode = true })

-- Neotest adapter for running Rust tests via rustaceanvim, when neotest is
-- available (it's an optional dependency -- not always installed).
pcall(function()
  require('neotest').setup {
    adapters = {
      ['rustaceanvim.neotest'] = {},
    },
  }
end)

-- vim: ts=2 sts=2 sw=2 et
