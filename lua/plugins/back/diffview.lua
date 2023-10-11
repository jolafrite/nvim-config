return {
  ["sindrets/diffview.nvim"] = {
    lazy = true,
    cmd = { "DiffviewOpen", "DiffviewClose" },
    config = require("editor.diffview"),
  }
}
