local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'nvim-treesitter/nvim-treesitter',
  lazy = false,
  config = function()
    local TS = require 'nvim-treesitter'

    local opts = {
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = true },
    }

    TS.setup(opts)
    local have = require('utils').treesitter.have

    local function enabled(feat, query, ft)
      local f = opts[feat] or {}
      return f.enable ~= false and have(ft, query)
    end
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('lazyvim_treesitter', { clear = true }),
      callback = function(ev)
        local ft = ev.match
        if not vim.treesitter.language.get_lang(ft) then return end

        if enabled('highlight', 'highlights', ft) then pcall(vim.treesitter.start, ev.buf) end

        if enabled('indent', 'indents', ft) then pcall(function() vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()" end) end

        if enabled('folds', 'folds', ft) then
          pcall(function()
            vim.wo[ev.buf].foldmethod = 'expr'
            vim.wo[ev.buf].foldexpr = "v:lua.require('nvim-treesitter').foldexpr()"
          end)
        end
      end,
    })
  end,
}
