return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        require("noice").setup({
            messages = {
                view = "notify",
            },
            markdown = {
                highlight = false,
            },
        }),
        lsp = {
            progress = {
                enabled = false, -- ✅ disables "Validate Document" spam
            },
            -- override = {
            --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            --     ["vim.lsp.util.stylize_markdown"] = true,
            --     ["cmp.entry.get_documentation"] = true,
            -- },
        },
        -- presets = {
        --     bottom_search = true,
        --     command_palette = true,
        --     long_message_to_split = true,
        --     inc_rename = false,
        --     lsp_doc_border = false,
        -- },
    },
}

-- return {
--     "folke/noice.nvim",
--     event = "VeryLazy",
--     dependencies = {
--         "MunifTanjim/nui.nvim",
--         "rcarriga/nvim-notify",
--     },
--     opts = {
--         messages = {
--             view = "notify",
--         },
--         markdown = {
--             highlight = false, -- ✅ fixes your Tree-sitter "tab" crash
--             links = false
--         },
--         lsp = {
--             progress = {
--                 enabled = false, -- ✅ disables "Validate Document" spam
--             },
--         },
--     },
-- }
--
