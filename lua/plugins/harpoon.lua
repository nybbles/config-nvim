return {
  {
    "ThePrimeagen/harpoon",
    lazy = true,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- Harpoon management
      { "<Leader>ha", function() require("harpoon"):list():add() end, desc = "Add file to Harpoon" },
      { "<Leader>hm", function() 
        local harpoon = require("harpoon")
        -- Temporarily disable autocommands during Harpoon menu creation to avoid snacks.nvim conflicts
        local eventignore = vim.o.eventignore
        vim.o.eventignore = "BufWinEnter,BufEnter"
        
        local ok, err = pcall(function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        
        -- Restore eventignore
        vim.o.eventignore = eventignore
        
        if not ok then
          vim.notify("Harpoon menu error: " .. tostring(err), vim.log.levels.WARN)
        end
      end, desc = "Toggle Harpoon menu" },
      { "<Leader>hd", function() require("harpoon"):list():remove() end, desc = "Remove file from Harpoon" },
      { "<Leader>hc", function() require("harpoon"):list():clear() end, desc = "Clear Harpoon list" },
      
      -- Leader+number bindings for quick file access
      { "<Leader>h1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
      { "<Leader>h2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
      { "<Leader>h3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
      { "<Leader>h4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
      { "<Leader>h5", function() require("harpoon"):list():select(5) end, desc = "Harpoon file 5" },
      { "<Leader>h6", function() require("harpoon"):list():select(6) end, desc = "Harpoon file 6" },
      { "<Leader>h7", function() require("harpoon"):list():select(7) end, desc = "Harpoon file 7" },
      { "<Leader>h8", function() require("harpoon"):list():select(8) end, desc = "Harpoon file 8" },
      { "<Leader>h9", function() require("harpoon"):list():select(9) end, desc = "Harpoon file 9" },
      
      -- Navigation
      { "<Leader>hn", function() require("harpoon"):list():next() end, desc = "Next Harpoon file" },
      { "<Leader>hp", function() require("harpoon"):list():prev() end, desc = "Previous Harpoon file" },
    },
    config = function()
      require("harpoon").setup({
        settings = {
          save_on_toggle = false,
          sync_on_ui_close = true,
          mark_branch = true,
        }
      })
    end,
  },
}