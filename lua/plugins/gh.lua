return {
  "ldelossa/gh.nvim",
  dependencies = {
    {
      "ldelossa/litee.nvim",
      config = function()
        require("litee.lib").setup({
          tree = {
            icon_set = "simple"
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
  lazy = false, -- Load immediately so commands are available
  keys = {
    -- Following gh.nvim's recommended structure
    { "<leader>g", group = "Git" },
    { "<leader>gh", group = "GitHub" },
    
    -- Commits
    { "<leader>ghc", group = "Commits" },
    { "<leader>ghcc", "<cmd>GHCloseCommit<cr>", desc = "Close" },
    { "<leader>ghce", "<cmd>GHExpandCommit<cr>", desc = "Expand" },
    { "<leader>ghco", "<cmd>GHOpenToCommit<cr>", desc = "Open To" },
    { "<leader>ghcp", "<cmd>GHPopOutCommit<cr>", desc = "Pop Out" },
    { "<leader>ghcz", "<cmd>GHCollapseCommit<cr>", desc = "Collapse" },
    
    -- Issues
    { "<leader>ghi", group = "Issues" },
    { "<leader>ghio", "<cmd>GHOpenIssue<cr>", desc = "Open" },
    { "<leader>ghip", "<cmd>GHPreviewIssue<cr>", desc = "Preview" },
    { "<leader>ghis", "<cmd>GHSearchIssues<cr>", desc = "Search" },
    
    -- Litee Panel
    { "<leader>ghl", group = "Litee" },
    { "<leader>ghlt", "<cmd>LTPanel<cr>", desc = "Toggle Panel" },
    
    -- Pull Requests
    { "<leader>ghp", group = "Pull Requests" },
    { "<leader>ghpc", "<cmd>GHClosePR<cr>", desc = "Close" },
    { "<leader>ghpd", "<cmd>GHPRDetails<cr>", desc = "Details" },
    { "<leader>ghpe", "<cmd>GHExpandPR<cr>", desc = "Expand" },
    { "<leader>ghpo", "<cmd>GHOpenPR<cr>", desc = "Open" },
    { "<leader>ghpp", "<cmd>GHPopOutPR<cr>", desc = "PopOut" },
    { "<leader>ghpr", "<cmd>GHRefreshPR<cr>", desc = "Refresh" },
    { "<leader>ghps", "<cmd>GHSearchPRs<cr>", desc = "Search" },
    { "<leader>ghpt", "<cmd>GHOpenToPR<cr>", desc = "Open To" },
    { "<leader>ghpz", "<cmd>GHCollapsePR<cr>", desc = "Collapse" },
    
    -- Reviews
    { "<leader>ghr", group = "Reviews" },
    { "<leader>ghra", "<cmd>GHApproveReview<cr>", desc = "Approve" },
    { "<leader>ghrb", "<cmd>GHStartReview<cr>", desc = "Begin" },
    { "<leader>ghrc", "<cmd>GHCloseReview<cr>", desc = "Close" },
    { "<leader>ghrd", "<cmd>GHDeleteReview<cr>", desc = "Delete" },
    { "<leader>ghre", "<cmd>GHExpandReview<cr>", desc = "Expand" },
    { "<leader>ghrs", "<cmd>GHSubmitReview<cr>", desc = "Submit" },
    { "<leader>ghrz", "<cmd>GHCollapseReview<cr>", desc = "Collapse" },
    
    -- Threads
    { "<leader>ght", group = "Threads" },
    { "<leader>ghtc", "<cmd>GHCreateThread<cr>", desc = "Create" },
    { "<leader>ghtn", "<cmd>GHNextThread<cr>", desc = "Next" },
    { "<leader>ghtt", "<cmd>GHToggleThread<cr>", desc = "Toggle" },
    
    -- Additional GitHub features
    { "<leader>ghn", "<cmd>GHNotifications<cr>", desc = "Notifications" },
    { "<leader>ghL", "<cmd>GHRequestedReview<cr>", desc = "PRs requesting review" },
    { "<leader>ghR", "<cmd>GHReviewed<cr>", desc = "Recently reviewed PRs" },
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

    -- Which-key groups are now defined in the keys table above

    -- Add completion for GitHub usernames and issues
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "gitcommit", "markdown" },
      callback = function()
        vim.opt_local.omnifunc = "v:lua.gh_complete"
      end,
    })
  end,
}