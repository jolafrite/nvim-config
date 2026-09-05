local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'nvim-treesitter/nvim-treesitter',
  lazy = false,
  config = function()
    local opts = {
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
    }
    local have = require('utils').treesitter.have

    local function enabled(feat, query, ft)
      local f = opts[feat] or {}
      return f.enable ~= false and have(ft, query)
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('my_treesitter', { clear = true }),
      callback = function(ev)
        local ft = ev.match
        if not vim.treesitter.language.get_lang(ft) then return end

        if enabled('highlight', 'highlights', ft) then pcall(vim.treesitter.start, ev.buf) end

        if enabled('indent', 'indents', ft) then pcall(function() vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()" end) end

        if enabled('folds', 'folds', ft) then
          pcall(function()
            vim.wo[ev.buf].foldmethod = 'expr'
            vim.wo[ev.buf].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end)
        end
      end,
    })

    -- Neovim 0.13: incremental selection to sibling treesitter nodes
    -- v_]N / v_[N expand selection to sibling nodes
    vim.keymap.set({ 'x', 'o' }, ']N', function()
      local ok, ts = pcall(require, 'nvim-treesitter')
      if ok and type(ts.select) == 'function' then
        ts.select()
      end
    end, { desc = 'Expand to sibling TS node' })
    vim.keymap.set({ 'x', 'o' }, '[N', function()
      local ok, ts = pcall(require, 'nvim-treesitter')
      if ok and type(ts.select) == 'function' then
        ts.select({ increment = false })
      end
    end, { desc = 'Shrink to parent TS node' })

    -- Neovim 0.13: vim.treesitter.select() starts/adjusts visual selection at cursor
    vim.keymap.set({ 'x', 'o' }, '<leader>ts', function()
      local ok, ts = pcall(require, 'nvim-treesitter')
      if ok and type(ts.select) == 'function' then
        ts.select()
      end
    end, { desc = 'Treesitter incremental selection' })
  end,
}
