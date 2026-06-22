return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        opts = {},
        keys = {
            {
                "<leader>e",
                "<CMD>Oil<CR>",
                desc = "Open Oil File Explorer (Local)"
            },
            {
                "<leader>E",
                function()
                    vim.ui.input({ prompt = "Enter remote host (user@hostname): " }, function(input)
                        if not input or input == "" then
                            return
                        end
                        input = input:gsub("%s+", "")
                        vim.cmd("edit oil-ssh://" .. input .. "/")
                    end)
                end,
                desc = "Open Oil File Explorer (Remote SSH)"
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
