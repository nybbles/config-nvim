return {
  "ldelossa/gh.nvim",
  dependencies = {
    {
      "ldelossa/litee.nvim",
      config = function()
        require("litee.lib").setup({
          tree = {
            icon_set = "codicons"
          },
          panel = {
            orientation = "right",
            panel_size = 30,
          }
        })
      end,
    },
    "folke/which-key.nvim",
  },
  cmd = {
    "GHOpenPR",
    "GHOpenIssue", 
    "GHSearchPRs",
    "GHSearchIssues",
    "GHStartReview",
    "GHSubmitReview",
    "GHDeleteReview",
    "GHApproveReview",
    "GHRequestedReview",
    "GHReviewed",
    "GHNotifications",
  },
  config = function()
    require("litee.gh").setup({
      -- disable keymaps to use our own
      disable_keymaps = false,
      -- Enable git buffer completion
      git_buffer_completion = true,
      -- Configure keymaps for gh.nvim buffers
      keymaps = {
        open = "<CR>",
        expand = "zo",
        collapse = "zc",
        goto_issue = "gd", 
        details = "d",
        submit_comment = "<C-s>",
        actions = "<C-a>",
        resolve_thread = "<C-r>",
        goto_web = "gx"
      }
    })

    -- Set up which-key integration for gh.nvim
    local wk = require("which-key")
    
    wk.add({
      { "<leader>g", group = "GitHub (gh.nvim)" },
      
      -- Pull Requests
      { "<leader>gp", "<cmd>GHOpenPR<cr>", desc = "Open Pull Request" },
      { "<leader>gs", "<cmd>GHSearchPRs<cr>", desc = "Search Pull Requests" },
      { "<leader>gl", "<cmd>GHRequestedReview<cr>", desc = "PRs Requesting Review" },
      { "<leader>gL", "<cmd>GHReviewed<cr>", desc = "Recently Reviewed PRs" },
      
      -- Issues  
      { "<leader>gi", "<cmd>GHOpenIssue<cr>", desc = "Open Issue" },
      { "<leader>gS", "<cmd>GHSearchIssues<cr>", desc = "Search Issues" },
      
      -- Reviews
      { "<leader>gr", "<cmd>GHStartReview<cr>", desc = "Start Review" },
      { "<leader>gR", "<cmd>GHSubmitReview<cr>", desc = "Submit Review" },
      { "<leader>ga", "<cmd>GHApproveReview<cr>", desc = "Approve Review" },
      { "<leader>gd", "<cmd>GHDeleteReview<cr>", desc = "Delete/Cancel Review" },
      
      -- Notifications & UI
      { "<leader>gn", "<cmd>GHNotifications<cr>", desc = "GitHub Notifications" },
      { "<leader>gt", "<cmd>LTPanel<cr>", desc = "Toggle Litee Panel" },
    })

    -- Add completion for GitHub usernames and issues
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "gitcommit", "markdown" },
      callback = function()
        vim.opt_local.omnifunc = "v:lua.gh_complete"
      end,
    })
  end,
}