return {
  {
    "olimorris/persisted.nvim",
    lazy = false,
    priority = 1000,
    keys = {
      { "<Leader>Ss", function() require("persisted").save() end, desc = "Save current session" },
      { "<Leader>Sr", function() require("persisted").load() end, desc = "Restore session for current directory" },
      { "<Leader>Sl", "<cmd>Telescope persisted<cr>", desc = "List sessions" },
      { "<Leader>Sd", function() require("persisted").delete() end, desc = "Delete current session" },
      { "<Leader>SD", function() require("persisted").stop() end, desc = "Stop session (disable autosave)" },
    },
    opts = {
      save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
      silent = false,
      use_git_branch = true,
      default_branch = "main",
      autosave = true,
      should_autosave = nil,
      autoload = false,
      on_autoload_no_session = nil,
      follow_cwd = true,
      allowed_dirs = nil,
      ignored_dirs = {
        "/",
        "/tmp",
        "/private/tmp",
        vim.fn.stdpath("data"),
        vim.fn.stdpath("cache"),
      },
      ignored_branches = {
        "main",
      },
      telescope = {
        reset_prompt = true,
        mappings = {
          change_branch = "<c-b>",
          copy_session = "<c-c>",
          delete_session = "<c-d>",
        },
      },
    },
    config = function(_, opts)
      require("persisted").setup(opts)
      
      -- Setup telescope extension
      vim.schedule(function()
        require("telescope").load_extension("persisted")
      end)
      
      -- Auto-save when leaving Neovim
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          if require("persisted").current() then
            require("persisted").save()
          end
        end,
      })
      
      -- Clean up terminal buffers before saving session
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedSavePre",
        callback = function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            local buftype = vim.bo[buf].buftype
            if buftype == "terminal" then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end,
      })
    end,
  },
}