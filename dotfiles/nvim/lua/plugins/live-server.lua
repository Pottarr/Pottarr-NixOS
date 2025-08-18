return {
  "barrett-ruth/live-server.nvim",
  build = false, -- don't run npm install (you already installed via Nix)
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = true,
  keys = {
    {
      "<leader>lt",
      function()
        local is_running = vim.g.live_server_running or false
        if is_running then
          vim.cmd("LiveServerStop")
          vim.g.live_server_running = false
        else
          vim.cmd("LiveServerStart")
          vim.g.live_server_running = true
        end
      end,
      desc = "Toggle Live Server",
    },
  },
}

