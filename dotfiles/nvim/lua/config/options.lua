-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.shiftwidth = 4       -- Size of an indent
vim.opt.tabstop = 4          -- Number of spaces tabs count for
vim.opt.softtabstop = 4      -- Number of spaces for editing operations
vim.opt.smartindent = true   -- Smart indentation

vim.diagnostic.config({
  virtual_text = true,  -- show inline messages
  signs = true,         -- show signs in the gutter
  underline = true,     -- underline issues
  update_in_insert = false, -- don't update while typing
  severity_sort = true,     -- sort by severity
})

