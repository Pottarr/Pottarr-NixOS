-- return {
--   "tanvirtin/monokai.nvim",
--   lazy = false,
--   init = function()
--     -- local palette = require("monokai")
--     -- palette.base2 = '#000000'
--     -- require("monokai").setup({ palette = palette })
--     require("monokai").setup({})
--   end,
--   enabled = true,
-- }

return {
    "LazyVim/LazyVim",
    dependencies = {
        -- Add your colorscheme plugin here (e.g., "catppuccin/vim")
        "tanvirtin/monokai.nvim",
        "blazkowolf/gruber-darker.nvim",
    },
    config = function()
        -- vim.cmd("colorscheme monokai")
        vim.cmd("colorscheme gruber-darker")
        -- Or if you want to use a function
        -- local catppuccin = require("catppuccin").load()
        -- catppuccin()
    end,
}
