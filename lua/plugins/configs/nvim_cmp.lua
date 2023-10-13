vim.g.completeopt = 'menu,menuone,noselect'

local cmp = require('cmp')
local types = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
  local unpack = unpack or table.unpack ---@diagnostic disable-line: deprecated
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  formatting = {
    -- fields = {'abbr', 'kind', 'menu'},
    format = require('lspkind').cmp_format({
      with_text = true,
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        cmp_tabnine = '[TabNine]',
        copilot = '[Copilot]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[NeovimLua]',
        latex_symbols = '[LaTeX]',
        path = '[Path]',
        omni = '[Omni]',
        spell = '[Spell]',
        emoji = '[Emoji]',
        calc = '[Calc]',
        rg = '[Rg]',
        treesitter = '[TS]',
        dictionary = '[Dictionary]',
        mocword = '[mocword]',
        cmdline = '[Cmd]',
        cmdline_history = '[History]',
      },
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
  }),
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require('cmp-under-comparator').under,
      function(entry1, entry2)
        local kind1 = entry1:get_kind()
        kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
        local kind2 = entry2:get_kind()
        kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
        if kind1 ~= kind2 then
          if kind1 == types.lsp.CompletionItemKind.Snippet then
            return false
          end
          if kind2 == types.lsp.CompletionItemKind.Snippet then
            return true
          end
          local diff = kind1 - kind2
          if diff < 0 then
            return true
          elseif diff > 0 then
            return false
          end
        end
      end,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 100 },
    { name = 'luasnip', priority = 20 },
    { name = 'path', priority = 100 },
    { name = 'emoji', insert = true, priority = 60 },
    { name = 'nvim_lua', priority = 50 },
    { name = 'nvim_lsp_signature_help', priority = 80 },
    { name = 'buffer', priority = 50 },
    { name = 'spell', priority = 40 },
    { name = 'calc', priority = 50 },
    { name = 'treesitter', priority = 30 },
    { name = 'dictionary', keyword_length = 2, priority = 10 },
  }, {}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' },
    { name = 'buffer' },
  }, {}),
})

-- autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
