return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },
  opts = {
    autowidth = {
      -- enable = true,
      winwidth = 20,
      winminwidth = 15,
    },
  },
  config = function(plugin, opts)
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false
    require("windows").setup(opts)
  end,
}
