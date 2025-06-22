return {
  "gbprod/yanky.nvim",
  opts = {},
  keys = {
    {
      "<leader>y",
      function() require("telescope").extensions.yank_history.yank_history({}) end,
      desc = "Open Yank History",
    },
  },
}