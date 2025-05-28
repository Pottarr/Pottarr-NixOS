return {
  "sylvanfranklin/omni-preview.nvim",
  enabled = false,
  dependencies = {
    -- Typst
    { 'chomosuke/typst-preview.nvim', lazy = true },
    -- CSV
    { 'hat0uma/csvview.nvim', lazy = true },
    -- Markdown
    -- { "toppair/peek.nvim", lazy = true, opt = { app = "google-chrome-stable", "--new-window" }, build = "deno task --quiet build:fast" }
    -- { "toppair/peek.nvim", lazy = true, opt = { app = "webview"}, build = "deno task --quiet build:fast" }
    { "wallpants/github-preview.nvim", lazy = true },
    -- { "iamcco/markdown-preview.nvim", lazy = true },
  },
  opts = {},
  keys = {
    { "<leader>po", "<cmd>OmniPreview start<CR>", desc = "OmniPreview Start" },
    { "<leader>pc", "<cmd>OmniPreview stop<CR>",  desc = "OmniPreview Stop" },
  }
}
