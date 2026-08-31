local gh = require("utils").gh

-- Only needed when an LSP attaches, so load on the first LSPAttach event
-- instead of at startup.
PackageManager.add({
  [1] = gh("VidocqH/lsp-lens.nvim"),
  event = "LSPAttach",
  config = function()
    require("lsp-lens").setup({
      sections = {
        definition = false,
        references = function(count)
          return "󰌹 Ref: " .. count
        end,
        implements = function(count)
          return "󰡱 Imp: " .. count
        end,
        git_authors = false,
      },
    })
  end,
})
