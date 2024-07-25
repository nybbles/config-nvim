return {
  "folke/trouble.nvim",
  opts = {
    win = {
      type = "split",
      position = "right",
      relative = "editor",
      size = { width = 0.3, height = 0.3 },
    },
    preview = {
      type = "float",
      relative = "editor",
      border = "rounded",
      title = "Preview",
      title_pos = "center",
      position = "right",
      size = { width = 0.3, height = 0.5 },
      zindex = 200,
    },
  },
  cmd = "Trouble",
}
