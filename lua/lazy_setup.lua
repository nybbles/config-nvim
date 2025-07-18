-- AstroNvim v5 configuration
-- Migrated from v4 with performance optimizations

require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^5",
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
  -- v5 uses snacks.nvim and blink.cmp, remove manual plugin specs
})