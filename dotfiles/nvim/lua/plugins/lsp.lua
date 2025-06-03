-- For NixOS ONLY because of the Filesystem Hierarchy Standard Problem ;-;

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")

    -- Setup each LSP server manually (because no Mason)
    lspconfig.bashls.setup({ mason = false, })
    lspconfig.clangd.setup({ mason = false, })
    lspconfig.gopls.setup({ mason = false, })
    lspconfig.nixd.setup({ mason = false, })
    lspconfig.pyright.setup({ mason = false, })
    lspconfig.tsserver.setup({ mason = false, })

    -- Lua LS config
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })

    -- Rust analyzer with diagnostics disabled
    lspconfig.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = false,
          },
        },
      },
    })

    -- You can add more servers here...
  end,
}

