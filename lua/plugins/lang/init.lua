-- Language plugin loader.
--
-- Each plugin file in lua/plugins/lang/*.lua registers a spec via
-- PackageManager.add() with a filetype trigger, so LSP configs (and their
-- treesitter/conform/lint wiring) only load when a buffer of that
-- filetype is opened — not at Neovim startup.
--
-- Some lang files are "config-only": they register vim.lsp.config servers
-- and call require('conform')/require('lint')/require('nvim-treesitter') at
-- top level, with no external plugin package. Those need
-- conform/lint/treesitter loaded first, so they run after load_all().
-- See config_only below.
--
--   1. load_specs()   — load the PackageManager.add spec files BEFORE
--      PackageManager.load_all() runs, so their filetype triggers are registered.
--   2. load_configs() — load the config-only files AFTER load_all().
--
-- The top-level init.lua calls require('plugins.lang').load_specs() before
-- require 'plugins' (which runs load_all()), then
-- require('plugins.lang').load_configs() after.

local lang_path = vim.fn.stdpath("config") .. "/lua/plugins/lang"

local config_only = {
  angular = true,
  astro = true,
  biome = true,
  clangd = true,
  dart = true,
  docker = true,
  dotnet = true,
  elixir = true,
  elm = true,
  ember = true,
  erlang = true,
  git = true,
  gleam = true,
  helm = true,
  json = true,
  julia = true,
  lua = true,
  markdown = true,
  nix = true,
  nushell = true,
  ocaml = true,
  oxc = true,
  php = true,
  prisma = true,
  python = true,
  rego = true,
  ruby = true,
  solidity = true,
  svelte = true,
  tailwind = true,
  terraform = true,
  toml = true,
  thrift = true,
  twig = true,
  typescript = true,
  typst = true,
  vue = true,
  yaml = true,
}

local M = {}

--- Load the PackageManager.add spec files (phase 1). Must run before
--- PackageManager.load_all() so filetype triggers are registered.
function M.load_specs()
  for _, file in ipairs(vim.fn.glob(lang_path .. "/*.lua", true, true)) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if name ~= "init" and not config_only[name] then
      local req_name = name:match("^%d+%-?(.*)$") or name
      if not package.loaded["plugins.lang." .. req_name] then
        local fn, err = loadfile(file)
        if not fn then
          error("loadfile " .. file .. ": " .. tostring(err))
        end
        fn()
        package.loaded["plugins.lang." .. req_name] = true
      end
    end
  end
end

--- Load the config-only files (phase 2). Call after load_all().
function M.load_configs()
  for _, name in ipairs({
    "angular",
    "astro",
    "biome",
    "clangd",
    "dart",
    "docker",
    "dotnet",
    "elixir",
    "elm",
    "ember",
    "erlang",
    "git",
    "gleam",
    "helm",
    "json",
    "julia",
    "lua",
    "markdown",
    "nix",
    "nushell",
    "ocaml",
    "oxc",
    "php",
    "prisma",
    "python",
    "rego",
    "ruby",
    "solidity",
    "svelte",
    "tailwind",
    "terraform",
    "toml",
    "thrift",
    "twig",
    "typescript",
    "typst",
    "vue",
    "yaml",
  }) do
    local file = lang_path .. "/" .. name .. ".lua"
    if not package.loaded["plugins.lang." .. name] then
      local fn, err = loadfile(file)
      if not fn then
        error("loadfile " .. file .. ": " .. tostring(err))
      end
      fn()
      package.loaded["plugins.lang." .. name] = true
    end
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
