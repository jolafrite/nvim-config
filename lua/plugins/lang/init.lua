-- Language plugin loader.

local lang_path = vim.fn.stdpath 'config' .. '/lua/plugins/lang'

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
  go = true,
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
  odin = true,
  php = true,
  prisma = true,
  python = true,
  rego = true,
  ruby = true,
  solidity = true,
  svelte = true,
  tailwind = true,
  terraform = true,
  thrift = true,
  toml = true,
  twig = true,
  typescript = true,
  typst = true,
  vue = true,
  xml = true,
  yaml = true,
}

local M = {}

--- Load the PackageManager.add spec files (phase 1). Must run before
--- PackageManager.load_all() so filetype triggers are registered.
function M.load_specs()
  for _, file in ipairs(vim.fn.glob(lang_path .. '/*.lua', true, true)) do
    local name = vim.fn.fnamemodify(file, ':t:r')
    if name ~= 'init' and not config_only[name] then
      local req_name = name:match '^%d+%-?(.*)$' or name
      if not package.loaded['plugins.lang.' .. req_name] then
        local fn, err = loadfile(file)
        if not fn then error('loadfile ' .. file .. ': ' .. tostring(err)) end
        fn()
        package.loaded['plugins.lang.' .. req_name] = true
      end
    end
  end
end

--- Load the config-only files (phase 2). Call after load_all().
function M.load_configs()
  for _, name in ipairs {
    'angular',
    'astro',
    'biome',
    'clangd',
    'dart',
    'docker',
    'dotnet',
    'elixir',
    'elm',
    'ember',
    'erlang',
    'go',
    'git',
    'gleam',
    'helm',
    'json',
    'julia',
    'lua',
    'markdown',
    'nix',
    'nushell',
    'ocaml',
    'odin',
    'php',
    'prisma',
    'python',
    'rego',
    'ruby',
    'solidity',
    'svelte',
    'tailwind',
    'terraform',
    'toml',
    'thrift',
    'twig',
    'typescript',
    'typst',
    'vue',
    'xml',
    'yaml',
  } do
    local file = lang_path .. '/' .. name .. '.lua'
    if not package.loaded['plugins.lang.' .. name] then
      local fn, err = loadfile(file)
      if not fn then error('loadfile ' .. file .. ': ' .. tostring(err)) end
      fn()
      package.loaded['plugins.lang.' .. name] = true
    end
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
