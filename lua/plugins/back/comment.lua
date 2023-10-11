return {
  ["numToStr/Comment.nvim"] = {
    lazy = true,
    event = { "CursorHold", "CursorHoldI" },
    config = require("editor.comment"),
  }
}
