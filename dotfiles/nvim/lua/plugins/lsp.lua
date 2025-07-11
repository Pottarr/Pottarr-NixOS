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
    lspconfig.jdtls.setup({
      -- on_attach = function(client, bufnr)
      on_attach = function(_, bufnr)
        -- Disable diagnostics for this buffer (Java only)
        vim.diagnostic.enable(true, bufnr)
      end,
    })
    lspconfig.nixd.setup({ mason = false, })
    lspconfig.pyright.setup({ mason = false, })
    lspconfig.tsserver.setup({ mason = false, })
    -- require('render-markdown').setup({
    --     completions = { lsp = { enabled = true } },
    -- })

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
            enable = true,
          },
        },
      },
    })

    -- You can add more servers here...

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = true,
    })


    lspconfig.gopls.setup({
      -- on_attach = function(client, bufnr)
      on_attach = function(_, bufnr)
        -- Go to definition
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
      end,
    })
  end,
}

