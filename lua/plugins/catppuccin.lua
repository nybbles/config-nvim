return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha", -- Use mocha flavor (dark) for consistency
    transparent_background = false,
    term_colors = true,
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
      nvimtree = true,
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
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
        inlay_hints = {
          background = true, 
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
      -- Remove navbuddy integration as it's not supported yet
      -- navbuddy = true,
      illuminate = {
        enabled = true,
        lsp = true,
      },
      which_key = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    -- Set colorscheme after options
    vim.cmd.colorscheme("catppuccin")
  end,
}
