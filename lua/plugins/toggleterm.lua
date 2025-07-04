return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm" },
  keys = { [[<leader>tt]] },
  opts = {
    open_mapping = [[<leader>tt]],
    direction = "vertical",
    shell = vim.o.shell,
    -- Performance optimizations
    shade_terminals = false,
    highlights = {
      Normal = { link = "Normal" },
      NormalFloat = { link = "NormalFloat" },
    },
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.25
      end
    end,
    winbar = {
      enabled = true,
    },
  },
  init = function(lazyPlugin)
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
  end,
}
