-- Lua language support.
local function setup(args)
  require('utils').install_with_mason { 'lua-language-server', 'stylua' }

  ---@type vim.lsp.Config
  local server = {
    name = 'lua_ls',
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_dir = require('utils').root.get { buf = args.buf, normalize = false },
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)
    end,
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        signatureHelp = { enabled = true },
        format = { enable = false },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      },
    },
  }

  vim.lsp.config('lua_ls', server)
  vim.lsp.start(server)

  local conform = require 'conform'
  conform.formatters_by_ft.lua = { 'stylua' }
end

require('utils').on_file_types({ 'lua' }, setup)
