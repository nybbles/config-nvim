return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Use split window instead of float for better usability
    win = {
      type = "split",
      position = "bottom",
      size = 10,
    },
    preview = {
      type = "main",
      -- Enter preview window on jump
      enter = true,
    },
    -- Focus trouble window when opened
    focus = true,
    -- Ensure proper highlighting
    use_diagnostic_signs = true,
    -- Auto close when no items
    auto_close = true,
    -- Auto preview
    auto_preview = true,
    -- Don't hijack quickfix
    open_no_results = false,
  },
  cmd = "Trouble",
  init = function()
    -- Prevent Trouble from hijacking quickfix
    vim.g.trouble_auto_open = false
    vim.g.trouble_auto_close = false
  end,
}
