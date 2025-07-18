-- Performance optimizations for Neovim startup
-- DISABLED for AstroNvim v5: v5 uses snacks.nvim and blink.cmp instead of these plugins
-- This file contains v4-specific optimizations that are no longer needed

if true then return {} end -- DISABLE: v4 optimizations not needed in v5

return {
  -- 1. Optimize Catppuccin theme loading (currently takes ~700ms)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false, -- Keep it non-lazy but optimize compile
    priority = 1000,
    opts = {
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      transparent_background = false,
      term_colors = false, -- Disable if not needed
      compile = {
        enabled = true,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
        suffix = "_compiled"
      },
      integrations = {
        -- Disable integrations you don't use to speed up loading
        aerial = false,
        alpha = false,
        cmp = true,
        dashboard = false,
        flash = false,
        gitsigns = true,
        headlines = false,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = false,
        lsp_trouble = false,
        mason = true,
        markdown = false,
        mini = false,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = false },
        neotree = true,
        neogit = false,
        neotest = false,
        notify = true,
        nvimtree = false,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = false,
        which_key = true,
      },
    },
  },

  -- 2. Lazy load heavy plugins that aren't needed at startup
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    event = "InsertEnter", -- Load only when entering insert mode
  },

  -- 3. Lazy load telescope extensions
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    keys = {
      { "<leader>f", desc = "Find" },
      { "<leader>l", desc = "LSP" },
      { "<leader>s", desc = "Search" },
    },
  },

  -- 4. Lazy load language-specific plugins
  {
    "pwntester/octo.nvim",
    lazy = true,
    cmd = "Octo",
  },

  -- 5. Lazy load development tools
  {
    "danymat/neogen",
    lazy = true,
    cmd = "Neogen",
  },

  -- 6. Optimize LSP loading
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" }, -- Load after buffer is read
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  },

  -- 7. Lazy load heavy UI components
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "TroubleToggle", "Trouble" },
  },

  -- 8. Consider disabling presence.nvim if not actively using Discord
  {
    "andweeb/presence.nvim",
    enabled = false, -- Disable to save startup time
  },

  -- 9. Lazy load file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = true,
  },

  -- 10. Optimize Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = { 
        -- Only install parsers you actually use
        "lua", "vim", "vimdoc", "python", "javascript", "typescript", 
        "rust", "go", "yaml", "json", "toml", "markdown", "bash"
      },
      auto_install = false, -- Don't auto-install parsers
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- Disable for performance
      },
    },
  },
}