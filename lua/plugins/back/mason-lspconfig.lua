return {
  ['williamboman/mason-lspconfig.nvim'] = {
    lazy = true,
    event = 'BufReadPre',
    config = require('completion.mason-lspconfig'),
    dependencies = {
      {
        'folke/neoconf.nvim',
        config = function()
          require('rc/pluginconfig/neoconf')
        end,
      },
      {
        'folke/neodev.nvim',
        config = function()
          require('rc/pluginconfig/neodev')
        end,
      },
    },
  },
}
-- dependencies = {
--     { "ray-x/lsp_signature.nvim" },
--     { "williamboman/mason.nvim" },
--     { "williamboman/mason-lspconfig.nvim" },
--     {
--         "glepnir/lspsaga.nvim",
--         config = require("completion.lspsaga"),
--     },
--     {
--          "nvimtools/none-ls.nvim",
--          dependencies = {
--             "nvim-lua/plenary.nvim",
--             "jay-babu/mason-null-ls.nvim",
--          },
--          config = require("completion.nullls"),
--     },
--     {
--         'antosha417/nvim-lsp-file-operations',
--         config = require("completion.fileoperation")
--     },
--
-- },
