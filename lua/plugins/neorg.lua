return {
  "nvim-neorg/neorg",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neorg/neorg-telescope",
    "folke/which-key.nvim",
  },
  build = ":Neorg sync-parsers",
  ft = "norg",
  cmd = "Neorg",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {
        config = {
          icon_preset = "diamond",
        },
      },
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.integrations.nvim-cmp"] = {},
      ["core.integrations.telescope"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "/Users/nimalan/code/notes",
          },
          default_workspace = "notes",
        },
      },
      ["core.journal"] = {
        config = {
          workspace = "notes",
        },
      },
      ["core.export"] = {},
      ["core.export.markdown"] = {
        config = {
          extensions = "all",
        },
      },
      ["core.summary"] = {},
      ["core.ui.calendar"] = {},
    },
  },
  config = function(_, opts)
    require("neorg").setup(opts)

    -- Set up which-key mappings for Neorg
    local wk = require("which-key")
    
    wk.register({
      n = {
        name = "Neorg",
        w = {
          name = "Workspace",
          w = { "<cmd>Neorg workspace notes<cr>", "Notes workspace" },
        },
        i = { "<cmd>Neorg index<cr>", "Open workspace index" },
        r = { "<cmd>Neorg return<cr>", "Return to previous buffer" },
        j = {
          name = "Journal",
          j = { "<cmd>Neorg journal today<cr>", "Today's journal" },
          y = { "<cmd>Neorg journal yesterday<cr>", "Yesterday's journal" },
          t = { "<cmd>Neorg journal tomorrow<cr>", "Tomorrow's journal" },
          c = { "<cmd>Neorg journal custom<cr>", "Custom date journal" },
        },
        d = {
          name = "Dirman", 
          d = { "<cmd>Neorg keybind norg core.dirman.new.note<cr>", "New note" },
        },
        t = {
          name = "Tasks",
          u = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_undone<cr>", "Mark undone" },
          p = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_pending<cr>", "Mark pending" },
          d = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<cr>", "Mark done" },
          h = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_on_hold<cr>", "Mark on hold" },
          c = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cancelled<cr>", "Mark cancelled" },
          r = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_recurring<cr>", "Mark recurring" },
          i = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_important<cr>", "Mark important" },
        },
        e = {
          name = "Export",
          m = { "<cmd>Neorg export to-file markdown<cr>", "Export to markdown" },
          d = { "<cmd>Neorg export directory markdown<cr>", "Export directory to markdown" },
        },
        s = {
          name = "Search", 
          f = { "<cmd>Telescope neorg find_norg_files<cr>", "Find norg files" },
          h = { "<cmd>Telescope neorg search_headings<cr>", "Search headings" },
          l = { "<cmd>Telescope neorg find_linkable<cr>", "Find linkable" },
          b = { "<cmd>Telescope neorg find_backlinks<cr>", "Find backlinks" },
        },
        c = { "<cmd>Neorg toggle-concealer<cr>", "Toggle concealer" },
        m = { "<cmd>Neorg inject-metadata<cr>", "Inject metadata" },
        u = { "<cmd>Neorg update-metadata<cr>", "Update metadata" },
      },
    }, { prefix = "<leader>" })

    -- Set up autocmds for better Neorg experience
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "norg",
      callback = function()
        -- Set up buffer-local keymaps for Neorg files
        local opts = { buffer = true, silent = true }
        
        -- Navigation
        vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", opts)
        vim.keymap.set("n", "<M-CR>", "<Plug>(neorg.esupports.hop.hop-link.vsplit)", opts)
        
        -- Lists and todos
        vim.keymap.set("n", "<C-Space>", "<Plug>(neorg.qol.todo-items.todo.task-cycle)", opts)
        
        -- Text objects
        vim.keymap.set("o", "iH", "<Plug>(neorg.text-objects.textobject.heading.inner)", opts)
        vim.keymap.set("x", "iH", "<Plug>(neorg.text-objects.textobject.heading.inner)", opts)
        vim.keymap.set("o", "aH", "<Plug>(neorg.text-objects.textobject.heading.outer)", opts) 
        vim.keymap.set("x", "aH", "<Plug>(neorg.text-objects.textobject.heading.outer)", opts)
      end,
    })

    -- Create notes workspace directory if it doesn't exist
    vim.fn.mkdir("/Users/nimalan/code/notes", "p")
  end,
}