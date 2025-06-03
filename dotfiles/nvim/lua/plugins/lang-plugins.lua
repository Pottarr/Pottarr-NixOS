return {
  {
    "neovim/nvim-lspconfig",
    event = "BufPreRead",
  },
  {
    "mason-org/mason.nvim",
    enabled = false,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    enabled = false,
  },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   config = function ()
  --     require("plugins.formatter")
  --   end
  -- },
}
