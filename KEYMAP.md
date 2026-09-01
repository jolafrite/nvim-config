# Keymap Reference

All keymaps in this config (vim.pack, not lazy.nvim). Leader is `,`.

Sources:

- `lua/config/keymaps.lua` — core/general
- `lua/plugins/lsp.lua` — LSP on_attach keymaps (capability-guarded)
- `lua/plugins/00-snacks.lua` — picker, toggles, terminal, lazygit
- `lua/plugins/{flash,gitsigns,grug-far,noice,todo-comments,trouble,treesitter-textobjects,yanky,neo-tree,neocodeium,conform,whichkey}.lua`
- `lua/plugins/lang/*.lua` — filetype-scoped keymaps

Generated from `vim.keymap.set(...)` calls and the which-key spec in the working tree.

## Movement & display

| Key | Modes | Action |
| --- | --- | --- |
| `j` / `k` | n,x | `v:count == 0 ? 'gj' : 'j'` (screen-aware down/up) |
| `<Down>` / `<Up>` | n,x | same, screen-aware (overrides the `<c-w>j`/`<c-w>k` mapping set earlier) |
| `n` / `N` | n,x,o | next/prev search, centered + `zv` (fold open) |
| `gg` / `GG` | n | top/bottom, centered |
| `%` | n | match pair, centered |
| `*` / `#` | n | word search, centered |
| `<C-u>` / `<C-d>` | n | scroll half-page, centered |
| `<C-i>` / `<C-o>` / `<C-m>` | n | jumplist forward/back, centered |
| `U` | n | redo (`<C-r>`) |
| `+` / `-` | n | increment / decrement number (`<C-a>` / `<C-x>`) |

## Window & pane

`<leader>w` is a which-key proxy for `<c-w>` (windows group), so `<c-w>` keys are also reachable as `<leader>w*`.

| Key | Modes | Action |
| --- | --- | --- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | n | move to adjacent window |
| `<C-Up>` / `<C-Down>` | n | resize height ±2 |
| `<C-Left>` / `<C-Right>` | n | resize width ±2 |
| `<Left>` / `<Right>` | n | move to left/right window (`<c-w>h` / `<c-w>l`) |
| `<c-w><space>` | n | window hydra mode (which-key, loop) |

Note: the old `<leader>-` / `<leader>|` splits and `<leader>wd` were removed — use the `<c-w>` / `<leader>w` window keys instead.

## Lines & editing

| Key | Modes | Action |
| --- | --- | --- |
| `<A-j>` / `<A-k>` | n | move line down/up (with count) |
| `<A-j>` / `<A-k>` | i | move line down/up, stay in insert |
| `<A-j>` / `<A-k>` | v | move selection down/up |
| `,` / `.` / `;` | i | undo break-point before punctuation |
| `<` / `>` | x | re-indent, keep visual |
| `dw` | n | delete word (`vd"_d` — visual-select + delete to black-hole) |
| `<C-a>` | n | select all (`gg<S-v>G`) |
| `<C-c>` | n | change inner word (`ciw`) |
| `gco` / `gcO` | n | comment line below/above |
| `<C-s>` | i,x,n,s | save |

## Search

| Key | Modes | Action |
| --- | --- | --- |
| `<esc>` | i,n,s | clear hlsearch + stop snippet + escape |
| `<leader>ur` | n | clear hlsearch, diff update, redraw |
| `<leader>?` | n | buffer keymaps (which-key) — overrides the Brave-search mapping set in `config/keymaps.lua` |
| `<leader>K` | n | keywordprg (`norm! K`) |

## Files

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>fn` | n | new file (`:enew`) |
| `<leader>e` | n | toggle Neo-tree (reveal current file) |

## Diagnostics

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>cd` | n | open diagnostic float |
| `]d` / `[d` | n | next/prev diagnostic (count-aware; the LSP buffer-local variant jumps without count) |
| `]e` / `[e` | n | next/prev error |
| `]w` / `[w` | n | next/prev warning |

## LSP (on_attach default, capability-guarded)

| Key | Modes | Action |
| --- | --- | --- |
| `gd` | n | `Snacks.picker.lsp_definitions` |
| `gr` | n | `Snacks.picker.lsp_references` |
| `gI` | n | `Snacks.picker.lsp_implementations` |
| `gy` | n | `Snacks.picker.lsp_type_definitions` |
| `gai` / `gao` | n | incoming / outgoing calls |
| `<leader>ss` / `<leader>sS` | n | document symbols / workspace symbols |
| `<leader>ca` | n,x | code action |
| `K` | n | hover |
| `<leader>rn` | n | rename |
| `<leader>cl` | n | LSP info (`Snacks.picker.lsp_config`) |
| `<leader>q` | n | diagnostics to loclist |

## Snacks picker

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>,` | n | buffers |
| `<leader>/` | n | grep (root) |
| `<leader>:` | n | command history |
| `<leader><space>` | n | find files (root) |
| `<leader>fb` / `<leader>fB` | n | buffers / all |
| `<leader>fc` | n | config files |
| `<leader>ff` / `<leader>fF` | n | find files (root / cwd) |
| `<leader>fg` | n | git-files |
| `<leader>fr` / `<leader>fR` | n | recent / recent (cwd) |
| `<leader>fp` | n | projects |
| `<leader>gd` / `<leader>gD` | n | git diff (hunks / origin) |
| `<leader>gs` / `<leader>gS` | n | git status / stash |
| `<leader>gi` / `<leader>gI` | n | gh issues (open / all) |
| `<leader>gp` / `<leader>gP` | n | gh PRs (open / all) |
| `<leader>sb` / `<leader>sB` | n | buffer lines / grep buffers |
| `<leader>sg` / `<leader>sG` | n | grep (root / cwd) |
| `<leader>sp` | n | plugin spec search |
| `<leader>sw` / `<leader>sW` | n,x | grep word (root / cwd) |
| `<leader>s"` | n,x | registers |
| `<leader>s/` | n | search history |
| `<leader>sa` / `<leader>sc` / `<leader>sC` | n | autocmds / command history / commands |
| `<leader>sd` / `<leader>sD` | n | diagnostics / buffer diagnostics |
| `<leader>sh` / `<leader>sH` | n | help / highlights |
| `<leader>si` / `<leader>sj` / `<leader>sk` | n | icons / jumps / keymaps |
| `<leader>sl` / `<leader>sM` / `<leader>sm` | n | loclist / man / marks |
| `<leader>sR` / `<leader>sq` / `<leader>su` | n | resume / quickfix / undotree |
| `<leader>uC` | n | colorschemes |

Within the picker input, `<a-c>` toggles cwd ↔ project root.

## Git

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>gg` / `<leader>gG` | n | lazygit (root / cwd) |
| `<leader>gL` / `<leader>gb` / `<leader>gf` / `<leader>gl` | n | git log (cwd) / blame line / file history / log (root) |
| `<leader>gB` / `<leader>gY` | n,x | git browse (open / copy) |

### Gitsigns hunks (buffer-local)

| Key | Modes | Action |
| --- | --- | --- |
| `]h` / `[h` | n | next / prev hunk (diff-aware) |
| `]H` / `[H` | n | last / first hunk |
| `<leader>ghs` / `<leader>ghr` | n,x | stage / reset hunk |
| `<leader>ghS` / `<leader>ghR` | n | stage / reset buffer |
| `<leader>ghu` | n | undo stage hunk |
| `<leader>ghp` | n | preview hunk inline |
| `<leader>ghb` | n | blame line (full) |
| `<leader>ghB` | n | blame buffer |
| `<leader>ghd` / `<leader>ghD` | n | diff this / diff this ~ |
| `ih` | o,x | select hunk (textobject) |

## Terminal

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>fT` / `<leader>ft` | n | terminal (cwd / root) |
| `<c-/>` / `<c-_>` | n,t | terminal focus (root) |

## Quickfix / loclist

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>xl` / `<leader>xq` | n | loclist / quickfix toggle |
| `[q` / `]q` | n | prev / next (trouble-aware: opens Trouble if present) |

## Trouble

| Key | Action |
| --- | --- |
| `<leader>xx` | diagnostics toggle |
| `<leader>xX` | diagnostics (buffer) |
| `<leader>cs` / `<leader>cS` | symbols / lsp toggle |
| `<leader>xL` / `<leader>xQ` | loclist / qflist toggle |

## Flash

| Key | Modes | Action |
| --- | --- | --- |
| `s` | n,x,o | flash jump |
| `S` | n,o,x | flash treesitter |
| `<c-space>` | n,o,x | treesitter incremental selection (`<BS>` steps back) |
| `r` / `R` | o | remote / treesitter search |
| `<c-s>` | c | toggle flash search |

## Yanky (yank/put)

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>p` | n,x | open yank history picker |
| `y` / `p` / `P` | n,x | yank / put after / put before (yanky-aware) |
| `gp` / `gP` | n,x | put after/before, leave cursor on put text |
| `[y` / `]y` | n | cycle backward / forward through yank history |
| `]p` / `[p` / `]P` / `[P` | n | put indented after/before (linewise) |
| `>p` / `<p` / `>P` / `<P` | n | put + shift right/left |
| `=p` / `=P` | n | put after/before applying a filter |

## Format (conform)

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>cf` | n,x | format (force) |
| `<leader>cF` | n | toggle format-on-save (per buffer) |

## Completion (neocodeium)

| Key | Modes | Action |
| --- | --- | --- |
| `<A-f>` | i | accept AI suggestion |

## Noice

| Key | Modes | Action |
| --- | --- | --- |
| `<c-b>` / `<c-f>` | i,n,s | lsp scroll backward/forward |
| `<S-Enter>` | c | redirect cmdline |
| `<leader>sn` | n | noice menu |
| `<leader>sna` / `snd` / `snh` / `snt` / `snl` | n | all / dismiss / history / pick / last |

## Todo comments

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>st` / `<leader>sT` | n | TodoTelescope / TODO,FIX,FIXME |
| `<leader>xt` / `<leader>xT` | n | Trouble todo / todo (tag-filtered) |
| `[t` / `]t` | n | prev / next todo comment |

## Grug far

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>sr` | n,x | search & replace (transient, per-filetype filter) |

## Treesitter textobjects (buffer-local, per-language query)

| Key | Modes | Action |
| --- | --- | --- |
| `]f` / `[f` | n,x,o | next / prev function start |
| `]F` / `[F` | n,x,o | next / prev function end |
| `]c` / `[c` | n,x,o | next / prev class start (falls back to `]c`/`[c` in diff mode) |
| `]C` / `[C` | n,x,o | next / prev class end |
| `]a` / `[a` | n,x,o | next / prev parameter start |
| `]A` / `[A` | n,x,o | next / prev parameter end |

## Snacks toggles

| Key | Action |
| --- | --- |
| `<leader>uG` | git signs |
| `<leader>us` / `uw` / `uc` / `ud` / `ul` / `uL` / `uA` / `uT` / `ub` / `uD` / `ua` / `ug` / `uS` | spelling / wrap / conceal / diagnostics / line number / relative number / tabline / treesitter / dark background / dim / animate / indent / scroll |
| `<leader>uh` | inlay hints (if supported) |
| `<leader>uI` | inspect treesitter tree |
| `<leader>ui` | inspect pos |
| `<leader>un` | dismiss all notifications |
| `<leader>n` | notification history |
| `<leader>wm` / `<leader>uz` | zoom / zen |
| `<leader>uZ` | zoom (alt) |
| `<leader>dpp` / `<leader>dph` | profiler / profiler highlights |

## Which-key

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>?` | n | buffer keymaps (which-key) |
| `<c-w><space>` | n | window hydra mode |
| `gx` | n | open with system app (label) |

Prefix groups: `<leader><tab>` (tabs), `<leader>c` (code), `<leader>d` (debug), `<leader>dp` (profiler), `<leader>f` (file/find), `<leader>g` / `<leader>gh` (git/hunks), `<leader>q` (quit/session), `<leader>s` (search), `<leader>u` (ui), `<leader>x` (diagnostics/quickfix), `[` (prev), `]` (next), `g` (goto), `gs` (surround), `z` (fold), `<leader>b` (buffer), `<leader>w` (windows, proxy for `<c-w>`).

## Filetype-specific

| Key | Modes | Filetype | Action |
| --- | --- | --- | --- |
| `<leader>D` | n | sql | toggle DBUI |
| `<leader>cR` | n | rust | rust-lsp code action |
| `<leader>dr` | n | rust | rust debuggables |
| `<C-P>` | n | typescript | better type hover |
| `<localleader>gj` | n,x | go | add `if err` |
| `<localleader>gt` / `gT` | n,x | go | run test near / run tests |
| `<localleader>gf` / `gi` | n,x | go | format (gofumpt) / fix imports |
| `<localleader>ge` | n,x | go | show test error output |
| `<leader>ta` | n | ansible | run playbook/role |
| `<Enter>` | n,x | r | send line / selection to R |
| `<localleader>e` | n | haskell | evaluate all |
| `<localleader>h` | n | haskell | hoogle signature |
| `<localleader>r` / `R` | n | haskell | REPL (package / buffer) |
| `<localleader>r` | n,x | lua | run Lua snippet (Snacks.debug.run) |

## Other

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>ue` | n | toggle Lsp Lens |
| `<leader>qq` | n | quit all |

All keymaps are made silent by default (`vim.keymap.set` is wrapped in `lua/config/options.lua`).
