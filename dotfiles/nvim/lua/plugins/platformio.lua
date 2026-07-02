return {
  "anurag3301/nvim-platformio.lua",
  cmd = {
    "Pioinit",
    "Piorun",
    "Pioupload",
    "Piomonitor",
    "Piocmd",
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "akinsho/nvim-toggleterm.lua",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("platformio").setup({})
  end,
}
