-- Optimized lazy_setup.lua for faster startup
-- Backup your current lazy_setup.lua before using this

require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^4",
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      autoread = true,
    },
  },
  -- Lazy load nvim-navbuddy
  { 
    "SmiteshP/nvim-navbuddy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    lazy = true,
    cmd = "Navbuddy",
    keys = {
      { "<leader>n", "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
    },
  },
  { import = "community" },
  { import = "plugins" },
}, {
  install = { colorscheme = { "astrodark", "habamax" } },
  defaults = {
    lazy = true, -- Make all plugins lazy by default
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "2html_plugin",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
        "tohtml",
      },
    },
  },
  -- Lazy load slow starting plugins
  spec = {
    { "catppuccin/nvim", lazy = false, priority = 1000 }, -- Keep theme non-lazy
    { "nvim-treesitter/nvim-treesitter", event = { "BufReadPost", "BufNewFile" } },
    { "neovim/nvim-lspconfig", event = { "BufReadPost", "BufNewFile" } },
    { "hrsh7th/nvim-cmp", event = "InsertEnter" },
    { "L3MON4D3/LuaSnip", event = "InsertEnter" },
    { "nvim-telescope/telescope.nvim", cmd = "Telescope" },
  },
})