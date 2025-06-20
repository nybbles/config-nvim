return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    -- Load for any markdown file in Documents folder
    "BufReadPre " .. vim.fn.expand "~" .. "/Documents/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Documents/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = function()
    -- Load vaults from local config file (gitignored)
    local ok, vaults = pcall(require, "obsidian-vaults")
    local workspaces = ok and vaults or {
      -- Fallback vault if config file doesn't exist
      {
        name = "notes",
        path = "~/Documents/notes",
      },
    }
    
    return {
      workspaces = workspaces,
      
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      
      -- Optional, configure key mappings. These are the defaults.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        }
      },
      
      -- Optional, for templates (see below).
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      
      -- Optional, customize how note IDs are generated given an optional title.
      note_id_func = function(title)
        -- Create human-readable, machine-parseable timestamp with timezone
        -- Format: YYYYMMDD-HHMMSS-TIMEZONE
        local timestamp = os.date("%Y%m%d-%H%M%S-%Z")
        
        local suffix = ""
        if title ~= nil and title ~= "" then
          -- If title is given, transform it into valid file name.
          suffix = "-" .. title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        end
        
        return timestamp .. suffix
      end,
      
      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = true,
    }
  end,
  config = function(plugin, opts)
    vim.opt_local.conceallevel = 2
    require("obsidian").setup(opts)
    
    
    -- Load custom obsidian functions
    local obsidian_custom = require("obsidian-custom")
    
    -- Set up keybindings
    vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Find/switch note" })
    vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search in vault" })
    vim.keymap.set("n", "<leader>on", function()
      -- Prompt for title and create new note in slip-box
      vim.ui.input({ prompt = "Note title: " }, function(title)
        if title then
          obsidian_custom.new_note(title)
        else
          obsidian_custom.new_note(nil)
        end
      end)
    end, { desc = "New note" })
    vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "Today's note" })
    vim.keymap.set("n", "<leader>oy", "<cmd>ObsidianYesterday<CR>", { desc = "Yesterday's note" })
    vim.keymap.set("n", "<leader>od", "<cmd>ObsidianTomorrow<CR>", { desc = "Tomorrow's note" })
    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show backlinks" })
    vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show links" })
    vim.keymap.set("n", "<leader>og", "<cmd>ObsidianTags<CR>", { desc = "Search tags" })
    vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian app" })
    vim.keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<CR>", { desc = "Paste image" })
    vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename note" })
    vim.keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "Switch workspace" })
    vim.keymap.set("n", "<leader>oe", "<cmd>ObsidianTemplate<CR>", { desc = "Insert template" })
    vim.keymap.set("n", "<leader>oq", function()
      -- Quick capture note with timestamp-based name
      obsidian_custom.quick_note()
    end, { desc = "Quick capture note" })
    
    -- Visual mode mappings
    vim.keymap.set("v", "<leader>ol", "<cmd>ObsidianLink<CR>", { desc = "Create link" })
    vim.keymap.set("v", "<leader>on", "<cmd>ObsidianLinkNew<CR>", { desc = "Create link to new note" })
  end,
}
