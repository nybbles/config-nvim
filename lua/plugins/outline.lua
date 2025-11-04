return {
  "hedyhli/outline.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons", -- For beautiful icons
  },
  cmd = { "Outline", "OutlineOpen" },
  keys = {
    { "<leader>a", "<cmd>Outline<cr>", desc = "Toggle Outline" },
  },
  opts = {
    outline_window = {
      position = "right",
      width = 35, -- Slightly wider for better readability
      relative_width = true,
      auto_close = false,
      auto_jump = false,
      jump_highlight_duration = 300,
      center_on_jump = true,
      show_numbers = false,
      show_relative_numbers = false,
      wrap = false,
      show_cursorline = true,
      hide_cursor = true,
      focus_on_open = false,
      winhl = "Normal:OutlineNormal,FloatBorder:OutlineBorder",
    },
    outline_items = {
      show_symbol_details = true,
      show_symbol_lineno = true,
      highlight_hovered_item = true,
      auto_set_cursor = true,
      auto_unfold_hover = true,
    },
    -- Symbol settings
    symbol_folding = {
      autofold_depth = 2, -- Auto-fold after depth 2
      auto_unfold = {
        hovered = true,
        only = true,
      },
    },
    -- Use built-in providers (LSP is primary)
    providers = {
      priority = { "lsp", "coc", "markdown", "man" },
      lsp = {
        blacklist_clients = {},
      },
    },
    -- Beautiful icons for different symbol types
    symbols = {
      icons = {
        File = { icon = "󰈙", hl = "Identifier" },
        Module = { icon = "󰆧", hl = "Include" },
        Namespace = { icon = "󰌗", hl = "Include" },
        Package = { icon = "󰏖", hl = "Include" },
        Class = { icon = "𝓒", hl = "Type" },
        Method = { icon = "ƒ", hl = "Function" },
        Property = { icon = "󰜢", hl = "Identifier" },
        Field = { icon = "󰽑", hl = "Identifier" },
        Constructor = { icon = "", hl = "Special" },
        Enum = { icon = "ℰ", hl = "Type" },
        Interface = { icon = "󰜰", hl = "Type" },
        Function = { icon = "", hl = "Function" },
        Variable = { icon = "󰀫", hl = "Constant" },
        Constant = { icon = "󰏿", hl = "Constant" },
        String = { icon = "𝓐", hl = "String" },
        Number = { icon = "#", hl = "Number" },
        Boolean = { icon = "⊨", hl = "Boolean" },
        Array = { icon = "󰅪", hl = "Constant" },
        Object = { icon = "⦿", hl = "Type" },
        Key = { icon = "🗝", hl = "Type" },
        Null = { icon = "NULL", hl = "Type" },
        EnumMember = { icon = "", hl = "Identifier" },
        Struct = { icon = "𝓢", hl = "Structure" },
        Event = { icon = "🗲", hl = "Type" },
        Operator = { icon = "+", hl = "Identifier" },
        TypeParameter = { icon = "𝙏", hl = "Identifier" },
        Component = { icon = "󰅴", hl = "Function" },
        Fragment = { icon = "󰅴", hl = "Constant" },
        -- Markdown specific
        ["markdown.heading"] = { icon = "󰉫", hl = "Identifier" },
      },
      -- Custom filter function to organize symbols
      filter = function(symbol)
        -- Hide some noisy symbols in certain languages
        local blacklist = {
          "Variable",
          "String",
          "Number",
          "Boolean",
          "Array",
        }
        
        -- Show all symbols for markdown and small files
        if vim.bo.filetype == "markdown" or vim.fn.line('$') < 100 then
          return true
        end
        
        -- Filter out blacklisted symbols for larger files
        return not vim.tbl_contains(blacklist, symbol.kind)
      end,
    },
    -- Beautiful tree guides
    guides = {
      enabled = true,
      markers = {
        bottom = "└",
        middle = "├",
        vertical = "│",
        horizontal = "─",
      },
    },
    -- Keymaps for the outline window
    keymaps = {
      show_help = "?",
      close = {"<Esc>", "q"},
      goto_location = "<Cr>",
      peek_location = "o",
      goto_and_close = "<S-Cr>",
      restore_location = "<C-g>",
      hover_symbol = "<C-space>",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
      fold = "h",
      unfold = "l",
      fold_toggle = "<Tab>",
      fold_toggle_all = "<S-Tab>",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
      down_and_goto = "<C-j>",
      up_and_goto = "<C-k>",
    },
  },
  config = function(_, opts)
    require("outline").setup(opts)
    
    -- Auto-refresh outline when Terraform files are saved
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.tf",
      callback = function()
        if require("outline").is_open() then
          vim.defer_fn(function()
            require("outline").refresh()
          end, 100) -- Small delay to ensure LSP has processed changes
        end
      end,
    })
    
    -- Theme-agnostic highlights using semantic groups
    vim.cmd([[
      " Use existing highlight groups that work with any theme
      hi link OutlineCurrent CursorLine
      hi link OutlineGuides LineNr
      hi link OutlineFile Directory
      hi link OutlineModule Include
      hi link OutlineNamespace Include
      hi link OutlineClass Type
      hi link OutlineMethod Function
      hi link OutlineFunction Function
      hi link OutlineProperty Identifier
      hi link OutlineField Identifier
      hi link OutlineVariable Identifier
      hi link OutlineConstant Constant
      hi link OutlineConstructor Special
      hi link OutlineEnum Type
      hi link OutlineInterface Type
      hi link OutlineStruct Structure
    ]])
  end,
}