return {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
        open_cmd = 'sh -c \'google-chrome-stable --app=%s\'',
    },
    keys = {
        {
        "<leader>tp",
        "<cmd>TypstPreviewToggle<CR>",
        desc = "Toggle Typst Preview",
        },
        { "<leader>mp", false },
    },
}
