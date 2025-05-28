return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
    },
  },
}

