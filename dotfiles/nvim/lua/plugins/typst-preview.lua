return {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {
        open_cmd = 'sh -c \'google-chrome-stable --app=%s\'',
    }, -- lazy.nvim will implicitly calls `setup {}`
}
