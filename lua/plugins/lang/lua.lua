-- Lua language support.
local function setup(args)
  local bufnr = args.buf

  -- Safe Mason install; ignore errors if a download is already in flight
  pcall(function()
    require('utils').install_with_mason { 'lua-language-server', 'stylua' }
  end)

  -- Tree-sitter parsers for Lua (mirrors the mason install pattern above).
  pcall(function()
    require('nvim-treesitter').install { 'lua', 'luadoc', 'luap' }
  end)

  -- Prevent duplicate server attachments on the same buffer
  if #vim.lsp.get_clients({ bufnr = bufnr, name = 'lua_ls' }) > 0 then return end

  ---@type vim.lsp.Config
  local server = {
    name = 'lua_ls',
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_dir = require('utils').root.get { buf = bufnr, normalize = false },
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
        completion = { callSnippet = 'Replace' },
        hint = { enable = true },
        workspace = {
          checkThirdParty = false,
          -- lazydev supplies Neovim API types, so avoid scanning the whole runtime tree
          library = {
            vim.env.VIMRUNTIME,
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          },
        },
        telemetry = { enable = false },
      },
    },
  }

  vim.lsp.config('lua_ls', server)
  vim.lsp.start(server)

  -- Register conform formatter without breaking startup if conform is unavailable
  pcall(function()
    local conform = require 'conform'
    if conform and conform.formatters_by_ft then
      conform.formatters_by_ft.lua = { 'stylua' }
    end
  end)
end

require('utils').on_file_types({ 'lua' }, setup)
