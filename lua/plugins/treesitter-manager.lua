local gh = require('utils').gh

-- Tree-sitter parser manager (`:TSUpgrade`). Needs a real buffer, so load on
-- first BufReadPost rather than at startup.
PackageManager.add {
  [1] = gh 'romus204/tree-sitter-manager.nvim',
  event = 'BufReadPost',
  config = function()
    require('tree-sitter-manager').setup {
      parser_dir = vim.fn.stdpath 'data' .. '/site/parser',
      query_dir = vim.fn.stdpath 'data' .. '/site/queries',
      auto_install = true,
    }
  end,
}

vim.api.nvim_create_user_command('TSUpgrade', function()
  local state = require 'tree-sitter-manager.config'
  local util = require 'tree-sitter-manager.util'
  local installer = require 'tree-sitter-manager.installer'
  local langs = vim.tbl_filter(function(lang) return util.is_installed(lang) end, state.languages)
  for _, lang in ipairs(langs) do
    installer.remove(lang)
  end
  local remaining = #langs
  for _, lang in ipairs(langs) do
    installer.install(lang, function() remaining = remaining - 1 end)
  end
  if #langs > 0 then vim.wait(900000, function() return remaining <= 0 end, 200) end
end, { nargs = 0, desc = 'Update all installed treesitter parsers' })

-- vim: ts=2 sts=2 sw=2 et
