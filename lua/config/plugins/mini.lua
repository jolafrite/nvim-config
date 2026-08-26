-- mini.nvim core: LazyVim does not call require("mini").setup().
-- Submodules (mini.pairs, mini.surround, mini.icons, mini.diff,
-- mini.files) are configured in their own files. Require the core
-- module here so it is loaded; it initializes lazily on demand.
require("mini")
