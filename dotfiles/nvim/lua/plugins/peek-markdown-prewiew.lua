return {
    "toppair/peek.nvim",
    cmd = { "PeekOpen", "PeekClose" }, -- better than VeryLazy here
    build = "deno task --quiet build:fast",
    config = function()
        local peek = require("peek")

        peek.setup({
              app = { 'google-chrome-stable', '--new-window' }
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
        vim.keymap.set("n", "<leader>mp", "<cmd>PeekOpen<CR>", {
            desc = "Markdown Preview (Peek)",
            silent = true,
        })

        vim.keymap.set("n", "<leader>mc", "<cmd>PeekClose<CR>", {
            desc = "Close Markdown Preview (Peek)",
            silent = true,
        })
    end,
}

