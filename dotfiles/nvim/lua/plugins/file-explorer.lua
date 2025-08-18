return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        opts = {},
        keys = {
            {
                "<leader>e",
                "<CMD>Oil<CR>",
                desc = "Open Oil File Explorer"
            }
        },
        -- Optional dependencies
        -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    { "nvim-neo-tree/neo-tree.nvim", enabled = false }
}
