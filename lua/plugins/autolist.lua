-- Automatic list continuation and renumbering for markdown
return {
  "gaoDean/autolist.nvim",
  ft = { "markdown", "text", "tex", "plaintex" },
  config = function()
    -- Setup autolist with default configuration
    require("autolist").setup()
    
    -- Debug: print when plugin loads
    print("autolist.nvim loaded successfully!")
    
    -- Set up keymaps according to official documentation
    local map = vim.keymap.set
    
    -- Insert mode mappings
    map("i", "<Tab>", "<cmd>AutolistTab<cr>", { desc = "Indent list item" })
    map("i", "<S-Tab>", "<cmd>AutolistShiftTab<cr>", { desc = "Dedent list item" })
    map("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", { desc = "Create new list item" })
    
    -- Normal mode mappings
    map("n", "o", "o<cmd>AutolistNewBullet<cr>", { desc = "New list item below" })
    map("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", { desc = "New list item above" })
    map("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", { desc = "Toggle checkbox" })
    
    -- Use 'm' prefix for markdown list operations  
    map("n", "<leader>mr", "<cmd>AutolistRecalculate<cr>", { desc = "Recalculate list numbering" })
    
    -- Cycle list types with dot-repeat support
    map("n", "<leader>mn", require("autolist").cycle_next_dr, { expr = true, desc = "Cycle to next list type" })
    map("n", "<leader>mp", require("autolist").cycle_prev_dr, { expr = true, desc = "Cycle to previous list type" })
    
    -- Alternative keymaps for easier access
    map("n", "<leader>mc", "<cmd>AutolistCycleNext<cr>", { desc = "Cycle list type" })
    
    -- Additional useful mappings
    map("n", "<leader>mt", "<cmd>AutolistToggleCheckbox<cr>", { desc = "Toggle checkbox" })
  end,
}