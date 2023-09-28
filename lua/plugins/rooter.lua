return {
  {
    "notjedi/nvim-rooter.lua",
    lazy = true,
    event = "BufRead",
    config = function() require 'nvim-rooter'.setup() end
  }
}
