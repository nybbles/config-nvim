return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
  keys = {
    { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
  },
  opts = {
    -- Use LSP as the primary backend, fallback to treesitter
    backends = { "lsp", "treesitter", "markdown", "man" },
    
    -- Basic layout settings
    layout = {
      default_direction = "right",
      width = 30,
    },
    
    -- Display settings
    show_guides = true,
    
    -- Place symbols in order they appear in code
    sort_by = "position",
    
    -- Don't filter out any kinds
    filter_kind = false,
    
    -- Additional settings
    highlight_on_hover = true,
    
    -- Nesting guides for better readability
    nesting_guides = {
      enabled = true,
      size = 1,
    },
  },
  config = function(_, opts)
    require("aerial").setup(opts)
    
    -- Try to load the telescope extension if available
    pcall(function() 
      require("telescope").load_extension("aerial")
      vim.keymap.set("n", "<leader>fs", "<cmd>Telescope aerial<cr>", { desc = "Find Symbol in File" })
    end)
  end,
}