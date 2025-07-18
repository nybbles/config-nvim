return {
  "RRethy/vim-illuminate",
  event = "User AstroFile",
  opts = {
    delay = 5000,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
    under_cursor = true,
    min_count_to_highlight = 1,
  },
  config = function(_, opts)
    require("illuminate").configure(opts)

    -- Let Catppuccin handle the highlighting via integration

    -- Add keymaps to navigate between references
    vim.keymap.set("n", "<leader>in", require("illuminate").goto_next_reference, { desc = "Go to next reference" })
    vim.keymap.set("n", "<leader>ip", require("illuminate").goto_prev_reference, { desc = "Go to previous reference" })
  end,
}