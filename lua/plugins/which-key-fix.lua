return {
  "folke/which-key.nvim",
  opts = {
    plugins = {
      presets = {
        operators = false, -- Disable operator pending mode mappings
        motions = false, -- Disable motion mappings
        text_objects = false, -- Disable text object mappings
      },
    },
    disable = {
      buftypes = { "terminal" }, -- Disable which-key in terminal buffers
      filetypes = { "toggleterm" }, -- Disable which-key in toggleterm buffers
    },
  },
}