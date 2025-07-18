return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    transparent_background = false,
    term_colors = false, -- Disabled for performance
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    compile = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/catppuccin",
      suffix = "_compiled"
    },
    dim_inactive = {
      enabled = false,
    },
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = { "italic" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
      aerial = true,
      cmp = true,
      gitsigns = true,
      nvimtree = false, -- Using neo-tree instead
      neotree = true,
      telescope = true,
      treesitter = true,
      notify = true,
      mason = true,
      navic = {
        enabled = true,
        custom_bg = "NONE",
      },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      dap = {
        enabled = true,
        enable_ui = true,
      },
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      illuminate = {
        enabled = true,
        lsp = true,
      },
      which_key = true,
      lsp_trouble = true,
      mini = false, -- Disable if not using mini plugins
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)

    -- Manual Trouble v3 highlight fixes
    vim.api.nvim_set_hl(0, "TroubleNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "TroubleText", { link = "Normal" })
    vim.api.nvim_set_hl(0, "TroubleCount", { link = "TabLineSel" })
    vim.api.nvim_set_hl(0, "TroubleDirectory", { link = "Directory" })
    vim.api.nvim_set_hl(0, "TroubleFileName", { link = "Directory" })
  end,
}
