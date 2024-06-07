return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
      },
      opts = {
        window = {
          border = "rounded",
          position = "30%",
        },
        lsp = {
          auto_attach = true,
        },
        source_buffer = {
          scrolloff = 0,
        },
      },
      config = function(plugin, opts)
        local navbuddy = require "nvim-navbuddy"
        navbuddy.setup(opts)
      end,
    },
  },
}
