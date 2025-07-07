-- File: ~/.config/nvim/lua/plugins/quarto.lua

-- This configuration adds Quarto support to AstroNvim v4
-- It sets up all the necessary components with intuitive keybindings
-- and browser-based visualization

return {
  -- Main Quarto plugin
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim", -- LSP support for embedded languages
      "nvim-treesitter/nvim-treesitter", -- Required for syntax highlighting
    },
    ft = { "quarto", "markdown", "rmd" }, -- Load only for these filetypes
    opts = {
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly", -- Use curly braces for chunk detection
        languages = { "r", "python", "julia", "bash", "html", "lua" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten", -- Use molten as the default runner
        -- You can specify different runners for different filetypes
        ft_runners = {
          python = "molten", -- Use molten for Python
          r = "molten", -- Use molten for R
          -- You can change to "iron" or "slime" if preferred
        },
        never_run = { "yaml", "json" }, -- Filetypes to never send to a runner
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)

      -- Set up key mappings for Quarto
      local map = vim.keymap.set
      local runner = require "quarto.runner"

      -- Document Preview - opens in external browser
      map("n", "<leader>qp", function()
        -- Use system's default browser for preview
        vim.cmd "QuartoPreview"
      end, { desc = "Quarto Preview in Browser", silent = true })

      map("n", "<leader>qq", "<cmd>QuartoClosePreview<cr>", { desc = "Close Quarto Preview", silent = true })

      -- Add help command
      map("n", "<leader>qh", "<cmd>QuartoHelp<cr>", { desc = "Quarto Help", silent = true })

      -- Use quarto runner for code execution (recognizes code blocks)
      map("n", "<leader>qc", runner.run_cell, { desc = "Run Code Cell", silent = true })
      map("n", "<leader>qa", runner.run_above, { desc = "Run All Cells Above", silent = true })
      map("n", "<leader>qA", runner.run_all, { desc = "Run All Cells", silent = true })
      map("n", "<leader>ql", runner.run_line, { desc = "Run Line", silent = true })
      map("v", "<leader>qr", runner.run_range, { desc = "Run Selected Range", silent = true })

      -- Run all code cells for all languages (useful in mixed-language documents)
      map(
        "n",
        "<leader>qm",
        function() runner.run_all(true) end,
        { desc = "Run All Cells (All Languages)", silent = true }
      )
    end,
  },

  -- Molten for Jupyter integration (output appears right in the editor)
  {
    "benlubas/molten-nvim",
    dependencies = {
      -- No need for image.nvim since we're using browser for visualizations
    },
    ft = { "python", "julia", "r", "quarto", "markdown" },
    build = ":UpdateRemotePlugins", -- Required for Molten
    init = function()
      -- Set up molten configuration
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_image_provider = false -- Disable in-terminal images
      vim.g.molten_auto_open_output = true -- Show output window when cursor enters a cell
      vim.g.molten_output_crop_border = true
      vim.g.molten_output_virt_lines = true -- Add virtual lines so output doesn't cover code
      vim.g.molten_virt_text_output = true -- Show persistent output as virtual text
      vim.g.molten_virt_lines_off_by_1 = true -- Place virtual text below code fence markers
      vim.g.molten_wrap_output = true -- Wrap long output lines

      -- Enable automatic browser opening for HTML outputs (like plots)
      vim.g.molten_auto_open_html_in_browser = true
      vim.g.molten_save_html_output = true

      -- Set the command to open URLs based on the OS
      if vim.fn.has "mac" == 1 then
        vim.g.molten_open_cmd = "open"
      elseif vim.fn.has "unix" == 1 then
        vim.g.molten_open_cmd = "xdg-open"
      elseif vim.fn.has "win32" == 1 or vim.fn.has "win64" == 1 then
        vim.g.molten_open_cmd = "start"
      end
    end,
    config = function()
      -- Set up key mappings for Molten
      local map = vim.keymap.set

      -- Initialize and basic operations
      map("n", "<leader>mi", "<cmd>MoltenInit<cr>", { desc = "Initialize Molten", silent = true })
      map("n", "<leader>mx", "<cmd>MoltenExit<cr>", { desc = "Exit Molten", silent = true })

      -- Cell evaluation
      map("n", "<leader>me", "<cmd>MoltenEvaluateOperator<cr>", { desc = "Run Operator Selection", silent = true })
      map("n", "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", { desc = "Run Current Line", silent = true })
      map("n", "<leader>mc", "<cmd>MoltenReevaluateCell<cr>", { desc = "Re-evaluate Cell", silent = true })
      map("v", "<leader>mr", ":<C-u>MoltenEvaluateVisual<cr>gv", { desc = "Run Visual Selection", silent = true })

      -- Cell navigation and management
      map("n", "<leader>mn", "<cmd>MoltenNext<cr>", { desc = "Next Cell", silent = true })
      map("n", "<leader>mp", "<cmd>MoltenPrev<cr>", { desc = "Previous Cell", silent = true })
      map("n", "<leader>md", "<cmd>MoltenDelete<cr>", { desc = "Delete Cell", silent = true })

      -- Output handling
      map("n", "<leader>mo", "<cmd>noautocmd MoltenEnterOutput<cr>", { desc = "Enter Output Window", silent = true })
      map("n", "<leader>mh", "<cmd>MoltenHideOutput<cr>", { desc = "Hide Output", silent = true })
      map("n", "<leader>ms", "<cmd>MoltenShowOutput<cr>", { desc = "Show Output", silent = true })

      -- Manually open in browser
      map("n", "<leader>mb", "<cmd>MoltenOpenInBrowser<cr>", { desc = "Open Output in Browser", silent = true })
    end,
  },

  -- Ensure we have treesitter support for quarto and related languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if opts.ensure_installed == "all" then return end
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "r",
        "python",
        "julia",
        "bash",
        "markdown",
        "markdown_inline",
        "yaml",
        "lua",
        "vim",
        "html",
        "css",
      })
    end,
  },
}
