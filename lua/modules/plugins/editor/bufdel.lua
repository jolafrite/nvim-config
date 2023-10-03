return {
  ["ojroques/nvim-bufdel"] = {
    lazy = true,
    event = "BufReadPost",
    config = require("editor.bufdel"),
  }
}
