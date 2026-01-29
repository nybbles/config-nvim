return {
  {
    "heilgar/bookmarks.nvim",
    lazy = true,
    -- Load only on demand (keys/commands) to avoid "false" echo on startup
    cmd = { "Bookmarks", "BookmarkAdd", "BookmarkListCreate", "BookmarkListRename" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
    },
    -- Patch storage.lua to fix sqlite schema mismatch bug (upstream issue #12)
    -- The plugin defines 6 columns but migrations add 2 more (branch, list),
    -- causing sqlite.lua's ensure check to fail
    build = function()
      local path = vim.fn.stdpath("data") .. "/lazy/bookmarks.nvim/lua/bookmarks/storage.lua"
      local ok, lines = pcall(vim.fn.readfile, path)
      if not ok then return end
      local content = table.concat(lines, "\n")
      -- Check if already patched
      if content:find('branch%s+= "text"') then return end
      -- Add branch and list columns to the schema definition
      content = content:gsub(
        '(project_root%s+= "text",)(\n\n%s+%-%- "ensure=true")',
        '%1\n                branch       = "text",    -- Git branch (for branch-specific bookmarks)\n                list         = "text",    -- Bookmark list name\n%2'
      )
      vim.fn.writefile(vim.split(content, "\n"), path)
    end,
    config = function()
      require("bookmarks").setup({
        db_path = vim.fn.stdpath("data") .. "/bookmarks.db",
        use_branch_specific = true,
        default_mappings = false,
      })
      require("telescope").load_extension("bookmarks")
    end,
    keys = {
      -- Quick access (like Arrow's ;)
      {
        ";",
        "<cmd>Telescope bookmarks list<cr>",
        desc = "Bookmarks (Telescope)",
      },
      -- Add bookmark at current line
      {
        "<Leader>ma",
        function()
          require("bookmarks").add_bookmark()
        end,
        desc = "Add bookmark",
      },
      -- Remove bookmark at current line
      {
        "<Leader>md",
        function()
          require("bookmarks").remove_bookmark()
        end,
        desc = "Delete bookmark",
      },
      -- List bookmarks in Telescope
      {
        "<Leader>ml",
        "<cmd>Telescope bookmarks list<cr>",
        desc = "List bookmarks",
      },
      -- Navigation
      {
        "<Leader>mn",
        function()
          require("bookmarks.navigation").jump_to_next()
        end,
        desc = "Next bookmark",
      },
      {
        "<Leader>mp",
        function()
          require("bookmarks.navigation").jump_to_prev()
        end,
        desc = "Previous bookmark",
      },
      -- List management
      {
        "<Leader>ms",
        "<cmd>Telescope bookmarks lists<cr>",
        desc = "Switch list",
      },
      {
        "<Leader>mc",
        ":BookmarkListCreate ",
        desc = "Create list",
      },
      {
        "<Leader>mr",
        ":BookmarkListRename ",
        desc = "Rename list",
      },
      {
        "<Leader>mt",
        function()
          require("bookmarks").toggle_branch_scope()
        end,
        desc = "Toggle branch scope",
      },
      -- Navigate with ] and [
      {
        "]m",
        function()
          require("bookmarks.navigation").jump_to_next()
        end,
        desc = "Next bookmark",
      },
      {
        "[m",
        function()
          require("bookmarks.navigation").jump_to_prev()
        end,
        desc = "Previous bookmark",
      },
    },
    specs = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>m"] = { desc = "Bookmarks" },
            },
          },
        },
      },
    },
  },
}
