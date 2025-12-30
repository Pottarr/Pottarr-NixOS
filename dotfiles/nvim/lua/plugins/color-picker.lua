return {
    "uga-rosa/ccc.nvim",
    branch = "0.7.2", -- optional if stable enough
    config = function()
        require("ccc").setup({
            highlighter = {
                auto_enable = true,
                lsp = true,
                highlight_mode = "virtual",
                virtual_pos = "inline-left",
            },
        })
    end,
}

