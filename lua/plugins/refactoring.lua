return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "python", "rust", "lua", "javascript", "typescript" },
  config = function()
    require("refactoring").setup({
      prompt_func_return_type = {
        python = true,
        rust = true,
      },
      prompt_func_param_type = {
        python = true,
        rust = true,
      },
      printf_statements = {},
      print_var_statements = {},
    })

    -- Refactoring keymaps
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "rust", "lua", "javascript", "typescript" },
      callback = function()
        local refactor = require("refactoring")
        
        -- Refactor selection menu
        vim.keymap.set("x", "<leader>r", function() refactor.select_refactor() end, { desc = "Refactor: Select Refactor", buffer = true })
        vim.keymap.set("n", "<leader>r", function() refactor.select_refactor() end, { desc = "Refactor: Select Refactor", buffer = true })
      end,
    })
  end,
}