-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.shiftwidth = 4       -- Size of an indent
vim.opt.tabstop = 4          -- Number of spaces tabs count for
vim.opt.softtabstop = 4      -- Number of spaces for editing operations
vim.opt.smartindent = true   -- Smart indentation
vim.opt.spell = true
vim.opt.spelllang= en_us
vim.o.termguicolors = true
vim.o.winborder = "rounded"

vim.api.nvim_create_autocmd(
    "ColorScheme", {
        callback = function()
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        end,
    }
)

vim.diagnostic.config({
    virtual_text = true,  -- show inline messages
    signs = true,         -- show signs in the gutter
    underline = true,     -- underline issues
    update_in_insert = false, -- don't update while typing
    severity_sort = true,     -- sort by severity
})

