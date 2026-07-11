return {
    "pottarr/peek.nvim",
    -- dir="~/Code/Projects/peek.nvim",
    cmd = { "PeekOpen", "PeekClose" },
    build = "deno task --quiet build:fast",
    ft = 'markdown',
    keys = {
        {
            "<leader>mp",
            function()
                local peek = require("peek")
                if peek.is_open() then
                    vim.cmd("PeekClose")
                else
                    vim.cmd("PeekOpen")
                end
            end,
            desc = "Toggle Markdown Preview",
        },
    },
    config = function()
        local peek = require("peek")

        peek.setup({
            app = { 'google-chrome-stable', '--app=' }
        })

        vim.api.nvim_create_user_command("PeekOpen", function()
            if not peek.is_open() and vim.bo.filetype == "markdown" then
                vim.fn.system("i3-msg split horizontal")
                peek.open()
            end
        end, {})

        vim.api.nvim_create_user_command("PeekClose", function()
            if peek.is_open() then
                peek.close()
                vim.fn.system("i3-msg move left")
            end
        end, {})
    end,
}

