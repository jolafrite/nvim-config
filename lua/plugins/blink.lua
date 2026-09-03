local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'saghen/blink.cmp',
  dependencies = {
    gh 'xzbdmw/colorful-menu.nvim',
    gh 'saghen/blink.lib',
    gh 'saghen/blink.indent',
    gh 'saghen/blink.pairs',
    gh 'Kaiser-Yang/blink-cmp-git',
    gh 'folke/lazydev.nvim',
    gh 'kristijanhusak/vim-dadbod-completion',
  },
  lazy = false,
  config = function()
    require('colorful-menu').setup {}
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
            columns = { { 'kind_icon' }, { 'label', gap = 1 } },
            components = {
              label = {
                text = function(ctx) return require('colorful-menu').blink_components_text(ctx) end,
                highlight = function(ctx) return require('colorful-menu').blink_components_highlight(ctx) end,
              },
            },
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
        default = { 'lazydev', 'lsp', 'dadbod', 'snippets', 'path', 'buffer' },
        providers = {
          buffer = {
            name = 'buffer',
            max_items = 4,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            fallbacks = { 'LSP' },
            score_offset = 100,
          },
          lsp = {
            name = 'LSP',
          },
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
          },
          path = {
            name = 'path',
            opts = {
              get_cwd = function(_) return vim.fn.getcwd() end,
            },
          },
          snippets = {
            name = 'snippets',
          },
        },
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
            auto_show = function() return vim.fn.getcmdtype() == ':' end,
          },
          ghost_text = { enabled = true },
        },
      },

      keymap = {
        preset = 'enter',
        ['<C-y>'] = { 'select_and_accept' },
      },
    }

    local ok, blink = pcall(require, 'blink.cmp')
    if ok and type(blink.build) == 'function' then
      local p = blink.build()
      if p and type(p.pwait) == 'function' then p:pwait() end
    end
  end,
}
