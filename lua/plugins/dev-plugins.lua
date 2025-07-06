-- Local development plugins
return {
  {
    "themester",
    dev = true,
    dir = "~/projects/themester",
    lazy = false,
    keys = {
      { "<leader>pr", "<cmd>lua package.loaded['themester'] = nil<cr><cmd>Lazy reload themester<cr>", desc = "Plugin reload: themester" },
    },
    config = function()
      require("themester").setup({
        default_theme = "roland-808",
        themes = {
          ["roland-808"] = require("themester.themes.roland_808"),
          ["garmin-instinct"] = require("themester.themes.garmin_instinct"),
          ["night-vision"] = require("themester.themes.night_vision"),
          ["matrix"] = require("themester.themes.matrix"),
        },
      })
    end,
  },
}