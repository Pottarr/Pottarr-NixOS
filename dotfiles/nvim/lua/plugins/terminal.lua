return {
--     "folke/edgy.nvim",
--     config = function()
--       require("edgy").setup({
--         bottom = {
--           {
--             title = "Snack Terminal",
--             ft = "snacks-terminal",   -- match buffers with this filetype
--             size = 15,
--             filter = function(bufnr)
--               return vim.bo[bufnr].filetype == "snacks-terminal"
--             end,
--           },
--         },
--       })
--     end,
--     opts = {},
}
