# Implementation Plan: Port KurisuNya Manager

**Branch:** `feat/manager-port`
**Spec:** `docs/superpowers/specs/2026-08-31-manager-port-design.md`

## Phase 1 — Foundation (verbatim port, low risk)

### 1.1 Port `lua/manager/` (verbatim from reference, path-fixed)

- `lua/manager/time.lua` — port verbatim, change `require("ffi")` stays, `Utils.os.is_mac` already global.
- `lua/manager/spec.lua` — port verbatim, change nothing internal (it uses `vim.*` only).
- `lua/manager/init.lua` — port verbatim, fix two internal requires:
  - `require("kurisunya.manager.time")` → `require('manager.time')`
  - `require("kurisunya.manager.spec")` → `require('manager.spec')`

### 1.2 Port `lua/utils/` submodules (verbatim)

- `lua/utils/safecall.lua` — verbatim (6.1K). Uses `Utils.safecall.EventCfg` alias only in annotations.
- `lua/utils/autocmd.lua` — verbatim (251B).
- `lua/utils/misc.lua` — verbatim (1.6K).
- `lua/utils/os.lua` — verbatim (696B).

### 1.3 Wire the `_G.Utils` global

In `lua/utils/init.lua`, add the four submodules to `M`, then register the
global so the Manager's bare `Utils.*` lookups resolve:

```lua
-- additions to existing M table
M.safecall = require('utils.safecall')
M.autocmd = require('utils.autocmd')
M.misc = require('utils.misc')
M.os = require('utils.os')
```

Register the global in the top-level `init.lua`, before `require('manager')`:

```lua
require 'utils'          -- populates M table
require 'config.options'
require 'config.keymaps'
require 'config.autocmds'
require 'config.pack'
_G.Utils = require('utils')   -- NEW: Manager calls Utils.* as bare global
require 'manager'             -- loads Manager + Spec + Time
require 'plugins.init'        -- Manager.add(...) for all plugins
```

`config/pack.lua` already registers `PackChanged` for telescope-fzf-native,
LuaSnip, nvim-treesitter builds — keep it. The Manager's own `PackChanged`
hook (builds) is deferred per spec §out-of-scope.

## Phase 2 — Convert plugin files

Two conversion templates. All files keep `local gh = require('utils').gh`.

### Template A — trivial, no setup, no keymaps (→ `lazy = false`, startup)

Before:

```lua
local gh = require('utils').gh
vim.pack.add { gh 'chrisgrieser/nvim-chainsaw' }
```

After:

```lua
local gh = require('utils').gh
Manager.add({ [1] = gh 'chrisgrieser/nvim-chainsaw', lazy = false })
```

Files: satellite, schemastore, shades-of-purple, yazi, cyberdream, e-ink,
lynn, namu, nivvie, nightfox, core, nui, plenary, nvim-nio, nvim-autopairs,
treesj, nvim-chainsaw, nvim-genghis, nvim-justice, nvim-rulebook,
nvim-scissors, nvim-spider, nvim-origami, nvim-jump,
nvim-various-textobjs, nvim-rip-substitute, tiny-autosave,
nvim-lsp-endhints, neocodeium.

### Template B — setup-bearing, startup (→ `lazy = false`, `config = function(opts) ... end`)

Before:

```lua
local gh = require('utils').gh
vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup { signs = { ... } }
-- keymaps
```

After:

```lua
local gh = require('utils').gh
Manager.add({
  [1] = gh 'lewis6991/gitsigns.nvim',
  lazy = false,
  config = function(opts)
    require('gitsigns').setup(vim.tbl_deep_extend('force', {
      signs = { ... },
    }, opts or {}))
    -- keymaps here
  end,
})
```

Files: 00-snacks, whichkey, mason, lsp, treesitter, gitsigns, noice, blink,
treesitter-textobjects, conform, nvim-lint, lualine, bufferline, mini,
neocodeium, pack, pack_float, neo-tree, fidget, flash, grug-far, refactoring,
todo-comments, lsp_lens, symbol_usage, workspace_diagnostics,
treesitter-manager, render-markdown, yanky, trouble, workspace_diagnostics.

### Template C — already lazy (→ `event`/`filetype` triggers)

Files that already wrap in `on_buf_read`/`on_file_types`/`on_lsp_attach` get
the equivalent `Manager.add` trigger:

| File | Current trigger | Manager equivalent |
| ------ | ---------------- | ------------------- |
| yanky | `on_buf_read` | `event = 'BufReadPost'` |
| trouble | `on_file_types('*')` | `filetype = '*'` (or `event = 'VeryLazy'`) |
| render-markdown | `on_file_types('markdown')` | `filetype = 'markdown'` |
| symbol_usage | `on_lsp_attach` | `event = 'LspAttach'` |
| workspace_diagnostics | `on_lsp_attach` | `event = 'LspAttach'` |
| treesitter-manager | `on_buf_read` | `event = 'BufReadPost'` |
| fidget | `on_lsp_attach` | `event = 'LspAttach'` |
| flash | `on_file_types('*')` | `filetype = '*'` |
| grug-far | `on_file_types('*')` | `filetype = '*'` |
| refactoring | `on_lsp_attach` | `event = 'LspAttach'` |
| todo-comments | `on_buf_read` | `event = 'BufReadPost'` |
| lsp_lens | `on_lsp_attach` | `event = 'LspAttach'` |
| nvim-autopairs | `on_file_types('*')` | `filetype = '*'` |
| indent-blankline | `on_file_types('*')` | `filetype = '*'` |
| indent-o-matic | `on_file_types('*')` | `filetype = '*'` |

`filetype = '*'` matches every filetype — semantically equivalent to the old
`on_file_types('*')`. `event = 'BufReadPost'` replaces `on_buf_read`.

### Template D — colorschemes (special)

`shades-of-purple.lua` and the colorscheme plugins stay as plain
`vim.pack.add` (they're loaded via `vim.cmd.colorscheme`, not the plugin
loader). Convert to `Manager.add({ lazy = false })` so they register but
don't auto-trigger a colorscheme.

## Phase 3 — Load chain

Replace `lua/plugins/init.lua`:

```lua
-- Old (deleted):
-- local plugin_path = ...; for _, file in ipairs(glob) do loadfile(file)() end

-- New:
return require('manager').load_all()
```

Replace `lua/plugins/lang/init.lua` similarly — but **batch 2 deferred**.
Keep the lang loop as-is until batch 2; it loads 50 lang files at boot as
today. Batch 1 proves the Manager works on the startup set first.

Update top-level `init.lua` per §1.3.

## Phase 4 — Verification

1. `luac -p lua/manager/*.lua lua/utils/{safecall,autocmd,misc,os}.lua` — syntax.
2. Boot: `nvim --headless -u init.lua -c 'lua print(require("manager").stats())' -c 'qa!'`
   → prints `{ loaded = N, total = M, startuptime = X }`, no error.
3. Confirm `:PackCheck` still works (pack.lua untouched).
4. Confirm a converted plugin's keymaps work (e.g. `<leader>ff` opens snacks picker).
5. Confirm a lang file still loads on `:e foo.ts` (lang loop untouched in batch 1).

## Order of execution

1. Port `lua/manager/` + `lua/utils/` submodules (Phase 1).
2. Wire `_G.Utils` + `init.lua` load chain (Phase 3 partial).
3. Convert Template A files (Phase 2A) — lowest risk, proves `Manager.add` works.
4. Convert Template C files (Phase 2C) — proves event/filetype triggers.
5. Convert Template B files (Phase 2B) — highest risk (setup + keymaps in `config`).
6. Replace `plugins/init.lua` with `Manager.load_all()` (Phase 3 complete).
7. Verify (Phase 4).
