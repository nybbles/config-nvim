return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  config = function()
    -- Reorganize vim-test mappings under <leader>t namespace to avoid conflicts
    -- with other plugins (<leader>a for Aerial, <leader>l for LSP)
    vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { desc = "Test Nearest" })
    vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { desc = "Test File" })
    vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>", { desc = "Test Suite" })
    vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { desc = "Test Last" })
    vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { desc = "Test Visit" })
    vim.cmd "let test#strategy = 'neovim'"
  end,
}
