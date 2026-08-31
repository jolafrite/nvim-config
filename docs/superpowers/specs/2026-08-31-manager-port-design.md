# Spec: Port KurisuNya Manager — spec-driven lazy plugin loading

**Date:** 2026-08-31
**Branch:** `feat/manager-port`
**Reference:** <https://github.com/KurisuNya/nvim-config/tree/main/lua/kurisunya/manager>

## 1. Goal

Adopt the spec-driven Manager pattern so plugin loading is **lazy by
event/filetype** instead of loading all 66 `lua/plugins/*.lua` files at boot.

Measured outcome: faster startup (only startup plugins load at boot), and a
single `Manager.add(spec)` schema replacing per-file `vim.pack.add` +
`require().setup` + inline keymaps.

## 2. Scope

### In scope

- Port `lua/kurisunya/manager/{init,spec,time}.lua` → `lua/manager/` (namespaced
  to `manager.`).
- Port the missing `Utils` dependencies from `lua/kurisunya/utils/`:
  `safecall`, `autocmd`, `misc`, `os` → `lua/utils/`, registered into the
  existing `utils` library.
- Convert **startup-critical plugin files** to the spec schema first
  (batch 1), then language files (batch 2+).
- Replace `lua/plugins/init.lua` loadfile loop with `Manager.load_all()`.

### Out of scope (explicitly deferred)

- Deleting `lua/plugins/pack.lua` / `pack_float.lua` (the custom manager).
- Converting the 50+ language plugin files (batch 2+).
- `Manager.update_all` with confirm+restart, `Manager.unmanaged`, `PackChanged`
  build hooks — these are additive and land after batch 1 proves the core.

## 3. Architecture

```
lua/
├── manager/
│   ├── init.lua     # Manager: add/load/load_all/update_all/stats/unmanaged
│   ├── spec.lua     # Spec schema + normalize
│   └── time.lua     # startup timing (ffi clock_gettime)
├── utils/
│   ├── init.lua     # _G.Utils = require('utils')  ← new global
│   ├── safecall.lua # now/later/when_events/when_filetypes (+ ftdetect redetect)
│   ├── autocmd.lua  # new_group()
│   ├── misc.lua     # tbl_set / list_insert_sorted / list_sort_stable
│   └── os.lua       # is_mac / is_linux / is_windows
└── plugins/
    ├── 00-snacks.lua ...   # Manager.add({ [1]=..., config=..., event=...|filetype=... })
    └── init.lua            # require('manager').load_all()  (replaces loadfile loop)
```

### Load chain

```
init.lua (top-level)
  → require('utils')            # registers _G.Utils
  → require('manager')          # loads Manager + Spec + Time
  → require('plugins.init')     # Manager.add(...) calls for batch-1 plugins
  → Manager.load_all()          # install-missing → restart → startup/event/filetype split
```

### Spec schema (from `spec.lua`)

```lua
---@class Manager.Spec
---@field [1] string|vim.pack.Spec          -- plugin spec for vim.pack
---@field dependencies?  (string|vim.pack.Spec)[]
---@field build?         string|fun(path: string)
---@field init?          fun()                       -- runs before ANY plugin loads
---@field opts?          table|fun(): table
---@field config?        fun(opts: table)            -- required if opts set
---@field event?         string|string[]|EventCfg[]
---@field filetype?      string|string[]
---@field priority?      number                      -- only for lazy=false, default 50
---@field lazy?          boolean                     -- default true
```

`Manager.add(spec)` normalizes via `Spec.normalize_spec`, validates every key
against `SPEC_KEYS`, stores in `H.plugin_specs[name]`. `Manager.load_all()`
sorts by `-priority`, runs `init` fns, then splits into:

- `startup_specs` (lazy=false) → loaded immediately
- `event_specs` → registered via `Utils.safecall.when_events`
- `filetype_specs` → registered via `Utils.safecall.when_filetypes`

## 4. Migration of a plugin file

Before (`lua/plugins/00-snacks.lua`):

```lua
local gh = require('utils').gh
vim.pack.add { gh 'folke/snacks.nvim' }
require('snacks').setup { ... }
-- inline keymaps
```

After:

```lua
local gh = require('utils').gh

Manager.add({
  [1] = gh 'folke/snacks.nvim',
  lazy = false,                        -- startup plugin
  init = function() ... end,           -- optional, runs before anything loads
  config = function(opts)
    require('snacks').setup(vim.tbl_deep_extend('force', {
      -- base config
    }, opts or {}))
    -- keymaps moved here, only run once snacks loads
  end,
})
```

For a lazy language plugin (`lua/plugins/lang/typescript.lua`):

```lua
Manager.add({
  [1] = gh 'pmizio/typescript-language-server',
  dependencies = { gh 'nvim-treesitter/nvim-treesitter' },
  filetype = { 'typescript', 'typescriptreact' },
  config = function()
    require('utils').install_with_mason { 'oxlint', 'prettier' }
    require('lint').linters_by_ft.typescript = { 'oxlint' }
    -- keymaps, treesitter install, etc.
  end,
})
```

## 5. Utils integration

The Manager calls `Utils.safecall.now/later/when_events/when_filetypes`,
`Utils.autocmd.new_group`, `Utils.misc.tbl_set/list_insert_sorted/list_sort_stable`,
`Utils.os.is_mac`. These are bare-global lookups.

In `lua/utils/init.lua`, add the four new submodules to the existing `M` table,
then expose the whole thing as a global:

```lua
-- at end of utils/init.lua, or in init chain
_G.Utils = require('utils')
```

The existing `utils` already has `gh`, `on_file_types`, `install_with_mason`,
`run_build`, `root`, `treesitter`, etc. — those stay. `Utils.safecall` etc.
are additive. No conflict.

## 6. What to do with pack.lua / pack_float.lua

**Keep `pack.lua` for now.** It owns `PackCheck`, `PackStatusChanged`, and the
auto-check timer — those are orthogonal to loading and don't collide with
Manager. Defer the decision on `pack_float` (float UI) until batch 2; if the
Manager's `update_all` proves sufficient, drop it then.

## 7. Batch plan

### Batch 1 (this spec) — startup-critical files

Convert these to `Manager.add` with `lazy = false` + `config`:

| File | Notes |
| ------ | ------- |
| `00-snacks.lua` | base; many keymaps move into `config` |
| `bufferline.lua` | currently disabled (commented out); leave disabled, note in spec |
| `lualine.lua` | statusline |
| `treesitter.lua` | parser installs |
| `conform.lua` | format-on-save autocmd |
| `nvim-lint.lua` | linters_by_ft tables |
| `keymaps.lua` | deleted in prior commit; replaced by per-plugin keymaps |
| `init.lua` | replaced by `Manager.load_all()` |

### Batch 2+ — language files (deferred)

All `lua/plugins/lang/*.lua` (50 files) → `Manager.add` with `filetype = {...}`.
This is the big startup win: 50 LSP configs stop loading at boot.

## 8. Verification

1. `luac -p` every new file (syntax check).
2. Boot nvim headless, confirm `Manager.load_all()` runs without error:
   `nvim --headless -u init.lua -c 'lua print(require("manager").stats())' -c 'qa!'`
3. Confirm startup time improves vs baseline (before batch 1, everything loaded).
4. Open a filetype that batch-1 didn't cover (e.g. `:e foo.ts`) and confirm the
   lang plugin loads on demand (check `vim.lsp.get_clients`).
5. Confirm `:PackCheck` still works (pack.lua untouched).

## 9. Risks

- **`Utils.safecall.when_filetypes` ftdetect redetect logic** is subtle; port
  verbatim rather than simplifying — it handles the case where a filetype's
  ftdetect scripts arrive after the first buffer of that type opened.
- **`Manager.add` errors on duplicate names** — if a plugin file is loaded
  both by the old loadfile loop and by Manager, it throws. Batch 1 must remove
  the old loadfile loop entirely (step in §3).
- **Keymaps formerly in `keymaps.lua`** were deleted last commit; they must
  move into the relevant plugin's `config` fn or a new `keymaps.lua` under
  Manager. Don't silently drop them — audit `git show HEAD:lua/plugins/keymaps.lua`
  for the old mapping list.
- **`pack_float.lua`** lazy-loads `plugins.pack` — if we keep pack.lua, ensure
  Manager doesn't `require('plugins.pack_float')` at load time.
