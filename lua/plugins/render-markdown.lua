return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { 
    "nvim-treesitter/nvim-treesitter", 
    "nvim-tree/nvim-web-devicons" -- for file type icons
  },
  ft = { "markdown", "vimwiki", "mdx" }, -- Support multiple markdown-like formats
  cmd = { "RenderMarkdown" },
  opts = {
    -- File types for which this plugin is enabled
    file_types = { "markdown", "vimwiki" },
    
    -- Render everything by default for the best experience
    render_modes = { "n", "v", "i", "c" }, -- Render in all modes
    
    -- Anti-conceal settings (make everything visible)
    anti_conceal = {
      -- Show normal markdown text when cursor is on same line
      enabled = true,
    },
    
    -- Latex rendering (if you use math in markdown)
    latex = {
      enabled = true,
      converter = "latex2text", -- Can also use 'latex2text' if available
      highlight = "RenderMarkdownMath",
    },
    
    -- Headings with beautiful icons and backgrounds
    heading = {
      enabled = true,
      sign = true,
      position = "overlay",
      icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      signs = { "󰫎 " },
      width = "full", -- Full width backgrounds for headers
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg", 
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    
    -- Code blocks with language icons
    code = {
      enabled = true,
      sign = true,
      style = "full",
      position = "left",
      language_pad = 0,
      disable_background = { "diff" }, -- Some languages look better without background
      width = "full",
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = "thin",
      above = "▄",
      below = "▀",
      highlight = "RenderMarkdownCode",
      highlight_inline = "RenderMarkdownCodeInline",
    },
    
    -- Dashes for horizontal rules
    dash = {
      enabled = true,
      icon = "─",
      width = "full",
      highlight = "RenderMarkdownDash",
    },
    
    -- Better bullet points
    bullet = {
      enabled = true,
      icons = { "•", "◦", "▸", "▹" },
      ordered_icons = { "1.", "a.", "i.", "A.", "I." },
      left_pad = 1,
      right_pad = 1,
      highlight = "RenderMarkdownBullet",
    },
    
    -- Interactive checkboxes with multiple states
    checkbox = {
      enabled = false,
      position = "inline",
      unchecked = {
        icon = "󰄱",
        highlight = "RenderMarkdownUnchecked",
        scope_highlight = nil,
      },
      checked = {
        icon = "󰱒",
        highlight = "RenderMarkdownChecked",
        scope_highlight = "@markup.strikethrough",
      },
      custom = {
        todo = { 
          raw = "[-]", 
          rendered = "󰥔", 
          highlight = "RenderMarkdownTodo",
          scope_highlight = "@markup.raw"
        },
        cancelled = { 
          raw = "[~]", 
          rendered = "󰰱", 
          highlight = "DiagnosticWarn",
          scope_highlight = "@markup.strikethrough"
        },
        important = { 
          raw = "[!]", 
          rendered = "󰀨", 
          highlight = "DiagnosticError",
          scope_highlight = nil
        },
        question = {
          raw = "[?]",
          rendered = "󰋗",
          highlight = "DiagnosticInfo",
          scope_highlight = nil
        },
        idea = {
          raw = "[*]",
          rendered = "󰌵",
          highlight = "DiagnosticHint",
          scope_highlight = nil
        },
      },
    },
    
    -- Beautiful quotes
    quote = {
      enabled = true,
      icon = "▍",
      repeat_linebreak = false,
      highlight = "RenderMarkdownQuote",
    },
    
    -- Gorgeous tables
    pipe_table = {
      enabled = true,
      preset = "heavy", -- 'none', 'round', 'double', 'heavy'
      style = "full",
      cell = "padded",
      min_width = 0,
      border = {
        -- Consistent heavy borders
        "┏", "┳", "┓",
        "┣", "╋", "┫", 
        "┗", "┻", "┛",
        "┃", "━",
      },
      alignment_indicator = "━",
      head = "RenderMarkdownTableHead",
      row = "RenderMarkdownTableRow",
      filler = "RenderMarkdownTableFill",
    },
    
    -- Callouts / Admonitions (GitHub style)
    callout = {
      note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
      abstract = { raw = "[!ABSTRACT]", rendered = "󰨸 Abstract", highlight = "RenderMarkdownInfo" },
      info = { raw = "[!INFO]", rendered = "󰋗 Info", highlight = "RenderMarkdownInfo" },
      todo = { raw = "[!TODO]", rendered = "󰗡 Todo", highlight = "RenderMarkdownInfo" },
      tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
      success = { raw = "[!SUCCESS]", rendered = "󰄬 Success", highlight = "RenderMarkdownSuccess" },
      hint = { raw = "[!HINT]", rendered = "󰰁 Hint", highlight = "RenderMarkdownHint" },
      important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
      warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
      attention = { raw = "[!ATTENTION]", rendered = "󰀪 Attention", highlight = "RenderMarkdownWarn" },
      caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
      danger = { raw = "[!DANGER]", rendered = "󱐌 Danger", highlight = "RenderMarkdownError" },
      error = { raw = "[!ERROR]", rendered = "󰅚 Error", highlight = "RenderMarkdownError" },
      bug = { raw = "[!BUG]", rendered = "󰨰 Bug", highlight = "RenderMarkdownError" },
      example = { raw = "[!EXAMPLE]", rendered = "󰉹 Example", highlight = "RenderMarkdownHint" },
      quote = { raw = "[!QUOTE]", rendered = "󱆨 Quote", highlight = "RenderMarkdownQuote" },
      cite = { raw = "[!CITE]", rendered = "󱆨 Cite", highlight = "RenderMarkdownQuote" },
    },
    
    -- Pretty links
    link = {
      enabled = true,
      image = "󰥶 ",
      email = "󰊫 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
      wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
    },
    
    -- Sign column icons for better visual structure
    sign = {
      enabled = true,
      highlight = "RenderMarkdownSign",
    },
    
    -- Indent guides for nested lists
    indent = {
      enabled = true,
      per_level = 2,
    },
    
    -- Window options to make markdown look better
    win_options = {
      showbreak = { default = "", rendered = "  " },
      breakindent = { default = false, rendered = true },
      breakindentopt = { default = "", rendered = "" },
      -- Proper line wrapping
      linebreak = { default = false, rendered = true },
      wrap = { default = false, rendered = true },
      -- Concealment level for prettier display
      conceallevel = { default = 0, rendered = 2 },
      concealcursor = { default = "", rendered = "nc" },
    },
    
    -- Custom handlers for specific patterns
    custom_handlers = {},
    
    -- Acknowledgements
    acknowledge_conflicts = true,
    log_level = "error",
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    
    -- Enhanced styling with better color choices for dark themes
    vim.cmd([[
      " Headers with bold styling - avoid ugly greens
      hi RenderMarkdownH1 gui=bold cterm=bold
      hi RenderMarkdownH2 gui=bold cterm=bold  
      hi RenderMarkdownH3 gui=bold cterm=bold
      hi RenderMarkdownH4 gui=bold cterm=bold
      hi RenderMarkdownH5 gui=italic cterm=italic
      hi RenderMarkdownH6 gui=italic cterm=italic
      hi link RenderMarkdownH1 Title
      hi link RenderMarkdownH2 Statement
      hi link RenderMarkdownH3 Keyword
      hi link RenderMarkdownH4 Type
      hi link RenderMarkdownH5 Function
      hi link RenderMarkdownH6 Identifier
      
      " Code blocks with background
      hi RenderMarkdownCode gui=NONE cterm=NONE
      hi RenderMarkdownCodeInline gui=italic cterm=italic
      hi link RenderMarkdownCode Visual
      hi link RenderMarkdownCodeInline String
      
      " Lists and checkboxes - avoid bright green
      hi RenderMarkdownBullet gui=bold cterm=bold
      hi RenderMarkdownChecked gui=bold cterm=bold
      hi RenderMarkdownUnchecked gui=NONE cterm=NONE
      hi RenderMarkdownTodo gui=bold cterm=bold
      hi link RenderMarkdownBullet Operator
      hi link RenderMarkdownChecked String
      hi link RenderMarkdownUnchecked Comment
      hi link RenderMarkdownTodo WarningMsg
      
      " Tables
      hi RenderMarkdownTableHead gui=bold cterm=bold
      hi link RenderMarkdownTableHead Title
      hi link RenderMarkdownTableRow Normal
      
      " Callouts - use less aggressive colors
      hi link RenderMarkdownInfo Function
      hi link RenderMarkdownSuccess String  
      hi link RenderMarkdownHint Identifier
      hi link RenderMarkdownWarn WarningMsg
      hi link RenderMarkdownError ErrorMsg
      
      " Other elements
      hi RenderMarkdownQuote gui=italic cterm=italic
      hi RenderMarkdownLink gui=underline cterm=underline
      hi link RenderMarkdownQuote Comment
      hi link RenderMarkdownLink Title
      hi link RenderMarkdownDash Comment
      hi link RenderMarkdownMath Number
    ]])
    
    -- Toggle command for quick enable/disable
    vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", { desc = "Toggle markdown rendering" })
  end,
}