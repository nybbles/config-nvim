-- Automatic list continuation and renumbering for markdown
return {
  "gaoDean/autolist.nvim",
  ft = { "markdown", "text" },
  config = function()
    require("autolist").setup({
      -- Enable automatic list continuation
      enabled = true,
      
      -- List configuration
      lists = {
        markdown = {
          -- Enable all markdown list types
          unordered = { "-", "*", "+" },
          ordered = function(c)
            -- Support for 1. 2. 3. style lists
            return c:match("^%d+%.")
          end,
          -- Support for checkbox lists
          todo = { "[ ]", "[x]", "[X]" },
        },
      },
      
      -- Automatic list continuation
      create_enter_mapping = true,
      
      -- Cycle between list types with a keybinding
      cycle = {
        "-",   -- Dash list
        "*",   -- Star list  
        "+",   -- Plus list
        "1.",  -- Numbered list
        "1)",  -- Parenthesis list
        "a)",  -- Letter list
        "[ ]", -- Checkbox
      },
      
      -- Indent behavior after colon
      colon = {
        indent = true,
        indent_raw = true,
        preferred = "-",
      },
      
      -- Checkbox configuration
      checkbox = {
        left = "%[",
        right = "%]",
        fill = "x",
      },
      
      -- Normal mode mappings
      normal_mappings = {
        -- Recalculate list to fix numbering
        recalculate = "<leader>lr",
        -- Cycle list type
        cycle = "<leader>lc", 
        -- Indent/dedent
        indent = ">>",
        dedent = "<<",
      },
      
      -- Insert mode mappings
      insert_mappings = {
        -- Tab to indent in lists
        indent = "<Tab>",
        dedent = "<S-Tab>",
      },
    })
    
    -- Additional keymaps for list management
    local map = vim.keymap.set
    
    -- Visual mode: recalculate selection
    map("v", "<leader>lr", "<cmd>AutolistRecalculate<cr>", { desc = "Recalculate selected list" })
    
    -- Toggle checkbox
    map("n", "<leader>lt", "<cmd>AutolistToggle<cr>", { desc = "Toggle checkbox" })
  end,
}