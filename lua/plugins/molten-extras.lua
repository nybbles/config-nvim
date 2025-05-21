-- File: ~/.config/nvim/lua/plugins/molten-extras.lua

-- This file contains additional configuration for image support
-- Only needed if you want to see images directly in the neovim interface

return {
  -- Image.nvim for displaying images inline
  {
    "3rd/image.nvim",
    ft = { "quarto", "markdown", "python", "julia", "r" },
    opts = {
      backend = "ueberzug", -- Try original ueberzug instead of ueberzug2
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "quarto" },
        },
        neorg = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    },
    -- Install instructions in comments
    -- build = function()
    --   -- Try installing original ueberzug if needed
    --   -- vim.fn.system("pip install ueberzug")
    -- end,
  },
}
