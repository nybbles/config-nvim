return {
  "f-person/auto-dark-mode.nvim",
  opts = {
    update_interval = 3000, -- Check every 3 seconds
    set_dark_mode = function()
      -- Set catppuccin to dark theme (mocha)
      vim.g.catppuccin_flavour = "mocha"
      vim.api.nvim_set_option_value("background", "dark", {})
      vim.cmd.colorscheme("catppuccin")
    end,
    set_light_mode = function()
      -- Set catppuccin to light theme (latte)
      vim.g.catppuccin_flavour = "latte"
      vim.api.nvim_set_option_value("background", "light", {})
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}