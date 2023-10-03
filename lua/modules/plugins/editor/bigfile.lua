return {
  ["LunarVim/bigfile.nvim"] = {
    lazy = false,
    config = require("editor.bigfile"),
    cond = require("core.settings").load_big_files_faster,
  }
}
