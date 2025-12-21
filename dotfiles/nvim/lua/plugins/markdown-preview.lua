-- return {
--   "iamcco/markdown-preview.nvim",
--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--   build = "cd app && npm install",
--   init = function()
--     -- function OpenMarkdownPreview(url)
--     --   vim.fn.jobstart({ "google-chrome-stable", "--new-window", url }, { detach = true })
--     -- end
--     vim.cmd([[
--       function! OpenMarkdownPreview(url)
--         silent! execute '!google-chrome-stable --new-window ' . shellescape(a:url)
--       endfunction
--     ]])
--     vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
--     vim.g.mkdp_filetypes = { "markdown" }
--     vim.g.mkdp_theme = "dark"
--   end,
--   ft = { "markdown" },
--   keys = {
--     {
--       "<leader>mp",
--       "<cmd>MarkdownPreviewToggle<cr>",
--       ft = "markdown",
--       desc = "Toggle Markdown Preview",
--     },
--   },
-- }

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  ft = { "markdown" },

  init = function()
    -- New Chrome window
    vim.cmd([[
      function! OpenMarkdownPreviewNewWindow(url)
        silent! execute '!google-chrome-stable --new-window ' . shellescape(a:url) . ' &'
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
  end,

  keys = {
    -- leader m p → NEW WINDOW
    {
      "<leader>mp",
      function()
        vim.g.mkdp_browserfunc = "OpenMarkdownPreviewNewWindow"
        vim.cmd("MarkdownPreview")
      end,
      ft = "markdown",
      desc = "Markdown Preview (new window)",
    },

    -- leader m P → SAME TAB (new tab in existing window)
    {
      "<leader>mP",
      function()
        vim.g.mkdp_browserfunc = "OpenMarkdownPreviewSameTab"
        vim.cmd("MarkdownPreview")
      end,
      ft = "markdown",
      desc = "Markdown Preview (same tab)",
    },
  },
}

