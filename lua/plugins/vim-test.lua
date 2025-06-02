return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  config = function()
    -- Test mappings moved to avoid conflict with terminal mappings
    vim.keymap.set("n", "<leader>Tn", ":TestNearest<CR>", { desc = "Test Nearest" })
    vim.keymap.set("n", "<leader>Tf", ":TestFile<CR>", { desc = "Test File" })
    vim.keymap.set("n", "<leader>Ta", ":TestSuite<CR>", { desc = "Test Suite" })
    vim.keymap.set("n", "<leader>Tl", ":TestLast<CR>", { desc = "Test Last" })
    vim.keymap.set("n", "<leader>Tv", ":TestVisit<CR>", { desc = "Test Visit" })
    vim.cmd "let test#strategy = 'neovim'"
  end,
}
