return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    -- function OpenMarkdownPreview(url)
    --   vim.fn.jobstart({ "google-chrome-stable", "--new-window", url }, { detach = true })
    -- end
    vim.cmd([[
      function! OpenMarkdownPreview(url)
        silent! execute '!google-chrome-stable --new-window ' . shellescape(a:url)
      endfunction
    ]])
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_theme = "dark"
  end,
  ft = { "markdown" },
  keys = {
    {
      "<leader>mp",
      "<cmd>MarkdownPreviewToggle<cr>",
      ft = "markdown",
      desc = "Toggle Markdown Preview",
    },
  },
}
