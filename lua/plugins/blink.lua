local gh = require('utils').gh

vim.pack.add {
  gh 'saghen/blink.lib',
  gh 'saghen/blink.cmp',
  gh 'saghen/blink.indent',
  gh 'saghen/blink.pairs',
  gh 'Kaiser-Yang/blink-cmp-git',
}

require('blink.cmp').setup {
  snippets = {
    preset = 'default',
  },

  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = 'mono',
  },

  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    menu = {
      draw = {
        treesitter = { 'lsp' },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = vim.g.ai_cmp,
    },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  cmdline = {
    enabled = true,
    keymap = {
      preset = 'cmdline',
      ['<Right>'] = false,
      ['<Left>'] = false,
    },
    completion = {
      list = { selection = { preselect = false } },
      menu = {
        auto_show = function(ctx) return vim.fn.getcmdtype() == ':' end,
      },
      ghost_text = { enabled = true },
    },
  },

  keymap = {
    preset = 'enter',
    ['<C-y>'] = { 'select_and_accept' },
  },
}

-- blink.cmp V2 ships a native Rust fuzzy matcher that must be compiled
-- (cargo build --release). A `build = function()` spec key was the
-- previous mechanism; vim.pack has no equivalent, so the build is
-- invoked here instead.
-- blink.lib short-circuits (~1ms) when the lib is already built, so calling
-- this on every startup is safe.
local ok, blink = pcall(require, 'blink.cmp')
if ok and type(blink.build) == 'function' then
  local p = blink.build()
  if p and type(p.pwait) == 'function' then p:pwait() end
end
