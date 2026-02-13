-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  LazyVim.cmp.actions.snippet_stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
map("n", "<a-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "move down" })
map("n", "<a-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "move up" })
map("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "move down" })
map("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "move up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })

-- LSP
map("n", "<a-d>", vim.diagnostic.open_float, { desc = "Show Diagnostic on Cursor" })

-- Buffer
map("n", "<Leader>bd", "<cmd>bd<CR>", { desc = "Close Current Buffer"})

-- Live Server
-- map("n", "<Leader>lt", "<cmd>!browser-sync start --server --files . &<CR>", { desc = "Toggle Live Server"})
-- map("n", "<Leader>lt", "<cmd>!bunx five-server . &<CR>", { desc = "Toggle Live Server"})
