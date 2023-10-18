local conf = {}

--
-- THEME CONFIGURATION
--
-- Available themes:
--   nightfox, tokyonight, dracula, kanagawa, catppuccin,
--   tundra, onedarkpro, everforest, monokai-pro
-- A configuration file for each theme is in lua/themes/
-- Use <F8> to step through themes
conf.theme = "tokyonight"
-- Available styles are:
--   kanagawa:    wave, dragon, lotus
--   tokyonight:  night, storm, day, moon
--   onedarkpro:  onedark, onelight, onedark_vivid, onedark_dark
--   catppuccin:  latte, frappe, macchiato, mocha, custom
--   dracula:     blood, magic, soft, default
--   nightfox:    carbonfox, dawnfox, dayfox, duskfox, nightfox, nordfox, terafox
--   monokai-pro: classic, octagon, pro, machine, ristretto, spectrum
conf.theme_style = "moon"
-- enable transparency if the theme supports it
conf.enable_transparent = true

-- 
-- GLOBAL OPTIONS CONFIGURATION
-- 
-- Some prefer space as the map leader, but why
conf.mapleader = ","
conf.maplocalleader = ","
-- Toggle global status line
conf.global_statusline = true
-- set numbered lines
conf.number = true
-- enable mouse see :h mouse
conf.mouse = "nv"
-- set relative numbered lines
conf.relative_number = true
-- always show tabs; 0 never, 1 only if at least two tab pages, 2 always
conf.showtabline = 2
-- enable or disable listchars
conf.list = true
-- which list chars to show
conf.listchars = {
  eol = "⤶",
  tab = ">.",
  trail = "~",
  extends = "◀",
  precedes = "▶",
}
-- use rg instead of grep
conf.grepprg = "rg --hidden --vimgrep --smart-case --"

-- 
-- PLUGINS CONFIGURATION
--
-- treesitter parsers to be installed
conf.treesitter_ensure_installed = {
  "bash",
  "c",
  "lua",
  "markdown",
  "markdown_inline",
  "query",
  "regex",
  "vim",
  "vimdoc",
}

-- LSPs that are installed by the Lazyman initialization
-- Leave the 'LSP_SERVERS' trailing comment, it is used by lazyman
conf.lsp_installed = {
  "cssls",         -- LSP_SERVERS
  "denols",        -- LSP_SERVERS
  "html",          -- LSP_SERVERS
  "jsonls",        -- LSP_SERVERS
  "lua_ls",        -- LSP_SERVERS
  "pylsp",         -- LSP_SERVERS
}

-- LSPs that should be installed by Mason-lspconfig
-- Leave the 'LSP_SERVERS' trailing comment, it is used by lazyman
conf.lsp_servers = {
  "bashls",        -- LSP_SERVERS
  "cssmodules_ls", -- LSP_SERVERS
  "dockerls",      -- LSP_SERVERS
  "emmet_ls",      -- LSP_SERVERS
  -- "eslint",     -- LSP_SERVERS
  -- "gopls",      -- LSP_SERVERS
  "graphql",       -- LSP_SERVERS
  "jdtls",         -- LSP_SERVERS
  "julials",       -- LSP_SERVERS
  "ltex",          -- LSP_SERVERS
  "marksman",      -- LSP_SERVERS
  "prismals",      -- LSP_SERVERS
  "pyright",       -- LSP_SERVERS
  "sqlls",         -- LSP_SERVERS
  "tailwindcss",   -- LSP_SERVERS
  "texlab",        -- LSP_SERVERS
  "tsserver",      -- LSP_SERVERS
  "vimls",         -- LSP_SERVERS
  "vuels",         -- LSP_SERVERS
  "yamlls",        -- LSP_SERVERS
}

-- Formatters and linters installed by Mason
conf.formatters_linters = {
  "actionlint",      -- FORMATTERS_LINTERS
  "gofumpt",         -- FORMATTERS_LINTERS
  "goimports",       -- FORMATTERS_LINTERS
  "golines",         -- FORMATTERS_LINTERS
  "golangci-lint",   -- FORMATTERS_LINTERS
  "google-java-format", -- FORMATTERS_LINTERS
  "latexindent",     -- FORMATTERS_LINTERS
  "markdownlint",    -- FORMATTERS_LINTERS
  "prettier",        -- FORMATTERS_LINTERS
  "sql-formatter",   -- FORMATTERS_LINTERS
  -- "shellcheck",   -- FORMATTERS_LINTERS
  "shfmt",           -- FORMATTERS_LINTERS
  "stylua",          -- FORMATTERS_LINTERS
  "tflint",          -- FORMATTERS_LINTERS
  "yamllint",        -- FORMATTERS_LINTERS
}

-- Formatters and linters installed externally
conf.external_formatters = {
  "beautysh",        -- FORMATTERS_LINTERS
  "black",           -- FORMATTERS_LINTERS
  "flake8",          -- FORMATTERS_LINTERS
  "ruff",            -- FORMATTERS_LINTERS
}

return conf
