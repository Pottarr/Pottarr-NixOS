-- For NixOS ONLY because of the Filesystem Hierarchy Standard Problem ;-;

-- Old LSP Config
if true then
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

            lspconfig.rust_analyzer.setup({
              settings = {
                  ["rust-analyzer"] = {
                      diagnostics = {
                          enable = true,
                      },
                  },
              },
            })
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = true,
            })



            -- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            -- local workspace_dir = vim.fn.expand("~/.local/share/jdtls/workspace/") .. project_name
            -- vim.fn.mkdir(workspace_dir, "p")
            --
            -- local util = require("jdtls.util")
            -- lspconfig.jdtls.setup({
            --     mason = false,
            --     -- Add `.projectroot` as a marker for project root detection
            --     root_dir = util.find_root({
            --         ".projectroot", -- ← our custom marker
            --         "pom.xml",
            --         "mvnw",
            --         "gradlew",
            --         ".git",
            --     }),
            --     cmd = { "jdtls", "-data", workspace_dir },
            -- })
        end,
    }
end

