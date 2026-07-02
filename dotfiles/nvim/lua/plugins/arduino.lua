return {
  "yuukiflow/Arduino-Nvim",
  ft = { "arduino", "ino" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    config_file = ".arduino_config.lua",
    board = "arduino:avr:uno",
    port = "/dev/ttyUSB0",
    baudrate = 115200,
    use_default_keymaps = true,
    use_default_commands = true,
  },
}
