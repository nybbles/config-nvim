return {
  "hedyhli/outline.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>a", "<cmd>Outline<cr>", desc = "Toggle Outline" },
  },
  opts = {
    outline_window = {
      -- Similar position and width as aerial
      position = "right",
      width = 30,
      -- Auto jump to location when selecting
      auto_jump = false,
      -- Show current location in outline
      show_cursorline = true,
      -- Hide the outline window when focus is lost
      hide_cursor = false,
    },
    outline_items = {
      -- Show tree lines
      show_symbol_details = true,
      -- Highlight hovered item
      highlight_hovered_item = true,
      -- Auto set cursor location in outline to match code location
      auto_set_cursor = true,
    },
    -- Symbol settings
    symbol_folding = {
      -- Start with all nodes expanded
      autofold_depth = false,
    },
    -- Use built-in providers (LSP is primary)
    providers = {
      priority = { "lsp", "markdown", "man" },
    },
    -- Icons and guides
    guides = {
      enabled = true,
      markers = {
        bottom = "└",
        middle = "├",
        vertical = "│",
      },
    },
  },
}