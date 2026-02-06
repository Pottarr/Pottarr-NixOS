return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  ft = { "markdown" },

  init = function()
    -- New Chrome window
    vim.cmd([[
      function! OpenMarkdownPreviewNewWindow(url)
        silent! execute '!google-chrome-stable --new-window --app=' . shellescape(a:url) . ' &'
      endfunction
    ]])

    -- Same Chrome session (new tab)
    vim.cmd([[
      function! OpenMarkdownPreviewSameTab(url)
        silent! execute '!google-chrome-stable ' . shellescape(a:url) . ' &'
      endfunction
    ]])

    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_open_to_the_world = 1
  end,

  keys = {
    -- leader m P → NEW WINDOW
    {
      "<leader>mP",
      function()
        vim.g.mkdp_browserfunc = "OpenMarkdownPreviewNewWindow"
        vim.cmd("MarkdownPreview")
      end,
      ft = "markdown",
      desc = "Markdown Preview (new window)",
    },

    -- leader m p → SAME TAB (new tab in existing window)
    {
      "<leader>mp",
      function()
        vim.g.mkdp_browserfunc = "OpenMarkdownPreviewSameTab"
        vim.cmd("MarkdownPreview")
      end,
      ft = "markdown",
      desc = "Markdown Preview (same tab)",
    },
  },
}

