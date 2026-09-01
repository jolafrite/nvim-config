# Keymap Reference

All keymaps in this config (vim.pack, not lazy.nvim). Leader is `,`.

Sources:

- `lua/config/keymaps.lua` — core/general (ported from LazyVim + local)
- `lua/plugins/lsp.lua` — LSP picker keymaps (on_attach default)
- `lua/plugins/{flash,gitsigns,grug-far,noice,00-snacks,todo-comments,trouble,treesitter-textobjects}.lua`

Generated from `vim.keymap.set(...)` calls in the working tree.

## Movement & display

| Key | Modes | Action |
| --- | --- | --- |
| `j` / `k` | n,x | `v:count == 0 ? 'gj' : 'j'` (screen-aware down/up) |
| `<Down>` / `<Up>` | n,x | same, screen-aware |
| `n` / `N` | n,x,o | next/prev search, centered (`zzzv`) |
| `gg` / `GG` / `G` | n | top / bottom / last line, all centered |
| `%` | n | match pair, centered |
| `*` / `#` | n | word search, centered |
| `<C-u>` / `<C-d>` / `<C-i>` / `<C-o>` | n | scroll half-page, centered |

## Window & pane

| Key | Modes | Action |
| --- | --- | --- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | n | move to adjacent window (remapped) |
| `<C-Up>` / `<C-Down>` | n | resize height ±2 |
| `<C-Left>` / `<C-Right>` | n | resize width ±2 |
| `<Up>` / `<Down>` / `<Left>` / `<Right>` | n | move window cursor (not char) |
| `<leader>-` | n | split below |
| `<leader>\|` | n | split right |
| `<leader>wd` | n | delete window |

## Lines & editing

| Key | Modes | Action |
| --- | --- | --- |
| `<A-j>` / `<A-k>` | n | move line down/up (with count) |
| `<A-j>` / `<A-k>` | i | move line down/up, stay in insert |
| `<A-j>` / `<A-k>` | v | move selection down/up |
| `,` / `.` / `;` | i | undo break-point before punctuation |
| `<` / `>` | x | re-indent, keep visual |
| `dw` | n | delete word backward to `" register |
| `<C-a>` | n | select all (`gg<S-v>G`) |
| `U` | n | redo (`<C-r>`) |
| `gco` / `gcO` | n | comment line below/above |
| `<C-s>` | i,x,n,s | save |

## Search

| Key | Modes | Action |
| --- | --- | --- |
| `<esc>` | i,n,s | clear hlsearch + stop snippet + escape |
| `<leader>ur` | n | clear hlsearch, diff update, redraw |
| `<leader>?` | n | search current word on Brave |
| `<leader>K` | n | keywordprg (`norm! K`) |

## Diagnostics

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>cd` | n | open diagnostic float |
| `]d` / `[d` | n | next/prev diagnostic |
| `]e` / `[e` | n | next/prev error |
| `]w` / `[w` | n | next/prev warning |
| `<leader>ciL` | n | list attached linters |

## LSP (on_attach default, capability-guarded)

| Key | Modes | Action |
| --- | --- | --- |
| `gd` | n | `Snacks.picker.lsp_definitions` |
| `gr` | n | `Snacks.picker.lsp_references` |
| `gI` | n | `Snacks.picker.lsp_implementations` |
| `gy` | n | `Snacks.picker.lsp_type_definitions` |
| `<leader>ss` | n | `Snacks.picker.lsp_symbols` |
| `<leader>sS` | n | `Snacks.picker.lsp_workspace_symbols` |
| `gai` | n | `Snacks.picker.lsp_incoming_calls` |
| `gao` | n | `Snacks.picker.lsp_outgoing_calls` |

## Buffers

| Key | Modes | Action |
| --- | --- | --- |
| `<S-h>` / `<S-l>` | n,x | bufferline prev/next |
| `[b` / `]b` | n | bufferline prev/next |
| `[B` / `]B` | n | bufferline move prev/next |
| `<leader>bp` | n | toggle pin |
| `<leader>bP` | n | close ungrouped |
| `<leader>bl` / `<leader>br` | n | close left/right |
| `<leader>bj` | n | pick buffer |

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

## Git

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>gg` / `<leader>gG` | n | lazygit (root / cwd) |
| `<leader>gL` / `<leader>gb` / `<leader>gf` / `<leader>gl` | n | git log (cwd) / blame line / file history / log (root) |
| `<leader>gB` / `<leader>gY` | n,x | git browse (open / copy) |

## Terminal

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>fT` / `<leader>ft` | n | terminal (cwd / root) |
| `<c-/>` / `<c-_>` | n,t | terminal focus (root) |

## Tabs

| Key | Action |
| --- | --- |
| `<leader><tab><tab>` | new tab |
| `<leader><tab>l` / `f` | last / first tab |
| `<leader><tab>]` / `[` | next / prev tab |
| `<leader><tab>o` / `d` | tabonly / close tab |

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
| `<c-space>` | n,o,x | treesitter incremental selection |
| `r` / `R` | o | remote / treesitter search |
| `<c-s>` | c | toggle flash search |

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
|---|---|---|
| `<leader>sr` | n,x | search & replace (transient, per-filetype filter) |

## Snacks toggles

| Key | Action |
| --- | --- |
| `<leader>uG` | git signs |
| `<leader>us` / `uw` / `uc` / `ud` / `ul` / `uL` / `uA` / `uT` / `ub` / `uD` / `ua` / `ug` / `uS` | spelling / wrap / conceal / diagnostics / line number / relative number / tabline / treesitter / bg / dim / animate / indent / scroll |
| `<leader>uh` | inlay hints (if supported) |
| `<leader>uI` | inspect treesitter tree |
| `<leader>ui` | inspect pos |
| `<leader>un` | dismiss all notifications |
| `<leader>n` | notification history |
| `<leader>wm` / `<leader>uz` | zoom / zen |
| `<leader>uZ` | zoom (alt) |
| `<leader>dpp>` / `<leader>dph>` | profiler / profiler highlights |

## Other

| Key | Modes | Action |
| --- | --- | --- |
| `<leader>ue` | n | toggle Lsp Lens |
| `<localleader>r` | n,x | run Lua (Snacks.debug.run) — lua files only |
| `<leader>qq` | n | quit all |
