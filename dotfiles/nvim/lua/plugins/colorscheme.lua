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
