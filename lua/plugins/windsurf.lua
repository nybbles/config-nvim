return {
  "Exafunction/windsurf.vim",
  event = "BufEnter",
  config = function()
    -- Default keybindings are already set by the plugin:
    -- <Tab> - Accept suggestion
    -- <M-]> - Next suggestion  
    -- <M-[> - Previous suggestion
    -- <C-]> - Clear current suggestion
    
    -- Optional: Disable for specific filetypes if needed
    -- vim.g.codeium_filetypes = {
    --   bash = false,
    --   sh = false,
    -- }
    
    -- Optional: Start disabled (uncomment to disable by default)
    -- vim.g.codeium_enabled = false
    
    -- Optional: Manual triggering only (uncomment for manual mode)
    -- vim.g.codeium_manual = true
  end,
}