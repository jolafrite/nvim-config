return {
  ["rhysd/clever-f.vim"] = {
    lazy = true,
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("editor.cleverf"),
  }
}
