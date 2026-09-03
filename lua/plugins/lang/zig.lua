local gh = require('utils').gh

PackageManager.add_with_mason { 'zls' }

-- vim.lsp.config('zls', {
--   cmd = { 'zls' },
--   filetypes = { 'zig', 'zir' },
--   root_markers = { 'zls.json', 'build.zig', '.git' },
-- })
-- vim.lsp.enable 'zls'

-- local TS = require 'nvim-treesitter'
-- pcall(TS.install, { 'zig' })

-- PackageManager.add({
--   [1] = gh 'lawrence-laz/neotest-zig',
--   filetype = {'zig', 'zir'},
--   config = function()
--     pcall(function()
--       require('neotest').setup {
--         adapters = {
--           ['neotest-zig'] = {},
--         },
--       }
--     end)
--   end,
-- })
