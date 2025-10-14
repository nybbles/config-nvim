return {
  "hasansujon786/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- For beautiful icons
  },
  lazy = false, -- Load immediately to ensure it's available
  keys = {
    { "<leader>ln", "<cmd>Navbuddy<CR>", desc = "Navbuddy (Code Structure)" },
  },
  config = function()
    require("nvim-navbuddy").setup({
      lsp = {
        auto_attach = true,
      },
    })
  end
}