return function()
  local icons = {
    kind = require('plugins.utils.icons').get('kind'),
    type = require('plugins.utils.icons').get('type'),
    cmp = require('plugins.utils.icons').get('cmp'),
  }

  local has_words_before = function()
    local unpack = unpack or table.unpack ---@diagnostic disable-line: deprecated
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local border = function(hl)
    return {
      { '╭', hl },
      { '─', hl },
      { '╮', hl },
      { '│', hl },
      { '╯', hl },
      { '─', hl },
      { '╰', hl },
      { '│', hl },
    }
  end

  local cmp = require('cmp')
  local types = require('cmp.types')
  local luasnip = require('luasnip')

  cmp.setup({
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
    window = {
      completion = {
        border = border('Normal'),
        max_width = 80,
        max_height = 20,
      },
      documentation = {
        border = border('CmpDocBorder'),
      },
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(_, vim_item)
        vim_item.menu = vim_item.kind
        vim_item.kind = string.format('%s', icons.kind[vim_item.kind] or '')

        return vim_item
      end,
    },
    sorting = {
      priority_weight = 2,
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
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    completion = {
      keyword_length = 1,
      completeopt = 'menu,noselect',
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'async_path' },
      { name = 'emoji', insert = true },
      { name = 'nvim_lua' },
      { name = 'nvim_lsp_signature_help' },
    }, {
      { name = 'buffer', keyword_length = 2 },
      -- { name = 'omni' },
      { name = 'spell' },
      { name = 'calc' },
      { name = 'treesitter' },
      { name = 'dictionary', keyword_length = 2 },
      { name = 'rg', keyword_length = 2 },
    }),
    -- ({
    --    { name = 'tmux' },
    --    { name = 'latex_symbols' },
    --    { name = 'orgmode' },
    --    {
    --      name = 'diag-codes',
    --      option = { in_comment = true },
    --    },
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' },
      { name = 'buffer' },
    }),
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'async_path' },
      { name = 'cmdline' },
    }, {
      { name = 'cmdline_history' },
    }),
  })

  cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
end
