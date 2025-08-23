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

            -- You can add more servers here...

            vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = true,
            })

            -- local root_dir = require('jdtls.setup').find_root({ ".git", "pom.xml", "build.gradle", "mvnw", "gradlew" })
            -- if not root_dir then
            --     print("Warning: Could not detect project root for jdtls!")
            --     return
            -- end

            -- local workspace_dir = vim.fn.expand("~/.local/share/eclipse/") .. vim.fn.fnamemodify(root_dir, ":p:h:t")
            -- vim.fn.mkdir(workspace_dir, "p")

            local root_dir = vim.fn.getcwd()  -- just use current directory
            local workspace_dir = vim.fn.expand("~/.local/share/jdtls/workspace")
            vim.fn.mkdir(workspace_dir, "p")

            lspconfig.jdtls.setup({
                cmd = { "/run/current-system/sw/bin/jdtls", "-data", workspace_dir },
                root_dir = root_dir,
                -- on_attach = on_attach,
                -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })



            lspconfig.jdtls.setup({
                mason = false,
                cmd = { "jdtls", "-data", workspace_dir },
                root_dir = root_dir,
                -- on_attach = on_attach,
                -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            -- lspconfig.gopls.setup({
            -- on_attach = function(client, bufnr)
            -- on_attach = function(_, bufnr)
            --     -- Go to definition
            --     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
            -- end,
            -- })
        end,
    }
end








-- Hybrid LSP config: Mason for supported servers, system binaries for NixOS-only LSPs
-- if false then
--     return {
--         "neovim/nvim-lspconfig",
--         event = { "BufReadPre", "BufNewFile" },
--         dependencies = {
--             "williamboman/mason.nvim",
--             "williamboman/mason-lspconfig.nvim",
--         },
--         config = function()
--             local lspconfig = require("lspconfig")
--             local mason_lspconfig = require("mason-lspconfig")
--
--             -- Setup Mason
--             require("mason").setup()
--             mason_lspconfig.setup({
--                 ensure_installed = {
--                     "bashls",
--                     "clangd",
--                     "gopls",
--                     "jdtls",
--                     "lua_ls",
--                     "pyright",
--                     "rust_analyzer",
--                     "ts_ls",
--                 },
--             })
--
--             -- On_attach function for general keymaps
--             local on_attach = function(_, bufnr)
--                 local opts = { buffer = bufnr, noremap = true, silent = true }
--                 vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--                 vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--                 vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--             end
--
--             -- LSPs handled by Mason
--             local mason_servers = { "bashls", "clangd", "gopls", "lua_ls", "pyright", "rust_analyzer", "ts_ls" }
--             for _, server in ipairs(mason_servers) do
--                 lspconfig[server].setup({
--                     on_attach = on_attach,
--                     capabilities = require("cmp_nvim_lsp").default_capabilities(),
--                 })
--             end
--
--             -- Java LSP (system only)
--             lspconfig.jdtls.setup({
--                 on_attach = function()
--                     -- Disable diagnostics for this buffer (Java only)
--                     vim.diagnostic.config({
--                         update_in_insert = false,
--                     })
--                 end,
--                 root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
--             })
--
--             -- Nix LSP (system only)
--             lspconfig.nixd.setup({
--                 on_attach = on_attach,
--                 mason = false,
--             })
--
--             -- Global diagnostic config
--             vim.diagnostic.config({
--                 virtual_text = true,
--                 signs = true,
--                 underline = true,
--                 update_in_insert = true,
--             })
--         end,
--     }
-- end
