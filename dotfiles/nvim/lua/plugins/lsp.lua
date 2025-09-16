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

            -- lspconfig.jdtls.setup({
            --     cmd = { "jdtls", "-data", vim.fn.expand("~/.local/share/jdtls/workspace/") .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") },
            --     root_dir = lspconfig.util.root_pattern(
            --         ".projectroot", -- custom marker
            --         "pom.xml",
            --         "mvnw",
            --         "gradlew",
            --         ".git"
            --     ),
            -- })


            -- Dynamically find the DSA Labs folder
            -- local function find_dsa_labs_root()
            --     local current_file = vim.fn.expand("%:p")
            --     -- Search for Data-Structure-and-Algorithm/Labs anywhere under / (root)
            --     local fd_cmd = {
            --         "fd",
            --         "--type", "d",
            --         "^Labs$",
            --         "/",           -- search from root
            --         "--max-depth", "6"  -- adjust depending on how deep your projects are
            --     }
            --     local fd_output = vim.fn.systemlist(fd_cmd)
            --
            --     -- Find the Labs folder that is under a parent named Data-Structure-and-Algorithm
            --     for _, path in ipairs(fd_output) do
            --         if path:match("Data%-Structure%-and%-Algorithm") and current_file:find(path, 1, true) then
            --             return path
            --         end
            --     end
            --
            --     -- Fallback to standard root detection
            --     return require("jdtls.util").find_root({
            --         ".projectroot",
            --         "pom.xml",
            --         "mvnw",
            --         "gradlew",
            --         ".git",
            --     })
            -- end
            --
            -- -- jdtls setup
            -- lspconfig.jdtls.setup({
            --     mason = false,
            --     root_dir = find_dsa_labs_root,
            --     cmd = {
            --         "jdtls",
            --         "-data",
            --         vim.fn.expand("~/.local/share/jdtls/workspace/") .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            --     },
            -- })





        end,
    }
end

