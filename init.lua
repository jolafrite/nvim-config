vim.loader.enable()

vim.pack.add({
  "https://github.com/comfysage/artio.nvim",
  "https://github.com/lewis6991/async.nvim",
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/Kaiser-Yang/blink-cmp-git",
  "https://github.com/saghen/blink.indent",
  "https://github.com/saghen/blink.pairs",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/scottmckendry/cyberdream.nvim",
  "https://github.com/e-ink-colorscheme/e-ink.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/yorickpeterse/nvim-jump",
  "https://github.com/comfysage/keymaps.nvim",
  "https://github.com/mfussenegger/nvim-lint",
  "https://github.com/chrisgrieser/nvim-lsp-endhints",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/comfysage/lylla.nvim",
  "https://github.com/comfysage/lynn.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/echasnovski/mini.files",
  "https://github.com/nvim-mini/mini.icons",
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/nvim-mini/mini.operators",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/nvim-mini/mini.surround",
  "https://github.com/nvim-mini/mini.visits",
  "https://github.com/bassamsdata/namu.nvim",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/monkoose/neocodeium",
  "https://github.com/EdenEast/nightfox.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/comfysage/nivvie.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/chrisgrieser/nvim-chainsaw",
  "https://github.com/chrisgrieser/nvim-genghis",
  "https://github.com/chrisgrieser/nvim-justice",
  "https://github.com/chrisgrieser/nvim-origami",
  "https://github.com/chrisgrieser/nvim-rip-substitute",
  "https://github.com/chrisgrieser/nvim-rulebook",
  "https://github.com/chrisgrieser/nvim-scissors",
  "https://github.com/chrisgrieser/nvim-spider",
  "https://github.com/kylechui/nvim-surround",
  "https://github.com/chrisgrieser/nvim-tinygit",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/chrisgrieser/nvim-various-textobjs",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/theprimeagen/refactoring.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/lewis6991/satellite.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/swaits/tiny-autosave.nvim",
  "https://github.com/folke/tokyonight.nvim",
  "https://github.com/Wansmer/treesj",
  "https://github.com/altermo/ultimate-autopair.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/mikavilpas/yazi.nvim",
  "https://github.com/AlexandrosAlexiou/kotlin.nvim",
  "https://github.com/VidocqH/lsp-lens.nvim",
  "https://github.com/kosayoda/nvim-lightbulb",
  "https://github.com/Wansmer/symbol-usage.nvim",
  "https://github.com/artemave/workspace-diagnostics.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})

require("config.init")
require("config.plugins")
require("config.lsp")

-- blink.cmp V2 ships a native Rust fuzzy matcher that must be compiled
-- (cargo build --release). lazy.nvim supported this via a `build = function()`
-- spec key; vim.pack has no equivalent, so the build is invoked here instead.
-- It is idempotent: ~1ms when the lib already exists, ~17s on first run, so
-- guarding on the lib's presence avoids rebuilding on every startup.
local function build_blink()
  local lib_dir = vim.fn.stdpath("data") .. "/pack/core/opt/blink.cmp/lib"
  local lib_file = lib_dir .. "/libblink_cmp_fuzzy" .. (vim.fn.has("mac") == 1 and ".dylib" or ".so")
  if vim.fn.filereadable(lib_file) == 1 then
    return
  end
  local ok, blink = pcall(require, "blink.cmp")
  if not ok or type(blink.build) ~= "function" then
    return
  end
  local p = blink.build()
  if p and type(p.pwait) == "function" then
    p:pwait()
  end
end
build_blink()
