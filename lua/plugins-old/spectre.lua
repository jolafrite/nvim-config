return {
  {
    "windwp/nvim-spectre",
    lazy = true,
    module = "spectre",
    config = function()
      require("spectre").setup()
    end,
  }
}
