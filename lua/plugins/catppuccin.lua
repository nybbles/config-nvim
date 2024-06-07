return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "auto",
    background = {
      light = "latte",
      dark = "mocha",
    },
    integrations = {
      aerial = true,
      neotree = true,
      navic = {
        enabled = true,
      },
      which_key = true,
    },
  },
}
