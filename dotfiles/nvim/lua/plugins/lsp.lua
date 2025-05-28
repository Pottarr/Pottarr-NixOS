-- For NixOS ONLY because of the Filesystem Hierarchy Standard Problem ;-;
return {
  "neovim/nvim-lspconfig",
  -- opts = {
  --   servers = {
  --     lua_ls = {
  --       mason = false,
  --       settings = {
  --         Lua = {
  --           diagnostics = {
  --             globals = { "vim" },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  config = function ()
    require("lspconfig").gopls.setup {}
    require("lspconfig").clangd.setup {}
    require("lspconfig").gopls.setup {}
    require("lspconfig").lua_ls.setup {}
    require("lspconfig").nixd.setup {}
    require("lspconfig").rust_analyzer.setup {}
  end
}

