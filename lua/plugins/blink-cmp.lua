-- Override AstroNvim's default blink.cmp config to use LuaSnip
return {
  "Saghen/blink.cmp",
  opts = function(_, opts)
    -- Use LuaSnip preset for advanced snippet features
    opts.snippets = {
      preset = "luasnip",
    }
    
    -- Enhanced keymap for snippets
    local has_words_before = function()
      local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
      ["<Tab>"] = {
        function(cmp)
          local luasnip = require("luasnip")
          -- If completion menu is visible, select next
          if cmp.is_visible() then
            return cmp.select_next()
          end
          -- If in snippet and can jump, do so
          if luasnip.locally_jumpable(1) then
            return luasnip.jump(1)
          end
          -- Handle hidden/expandable snippets
          if luasnip.expandable() then
            return luasnip.expand()
          end
          -- If we have words before cursor in command mode, show completion
          if vim.api.nvim_get_mode().mode == "c" and has_words_before() then 
            return cmp.show() 
          end
          -- For normal indentation, fallback to default Tab behavior
          return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", false)
        end,
      },
      ["<S-Tab>"] = {
        "select_prev",
        "snippet_backward",
        function(cmp)
          if vim.api.nvim_get_mode().mode == "c" then 
            return cmp.show() 
          end
        end,
        "fallback",
      },
      ["<C-l>"] = {
        function()
          local luasnip = require("luasnip")
          if luasnip.choice_active() then
            luasnip.change_choice(1)
          end
        end,
        "fallback",
      },
    })

    -- Enhanced completion menu with snippet indicators
    if not opts.completion then opts.completion = {} end
    if not opts.completion.menu then opts.completion.menu = {} end
    if not opts.completion.menu.draw then opts.completion.menu.draw = {} end
    if not opts.completion.menu.draw.components then opts.completion.menu.draw.components = {} end
    
    -- Add snippet source indicator
    opts.completion.menu.draw.components.source_name = {
      text = function(ctx)
        local source_name = ctx.item.source_name
        if source_name == "Snippets" then
          return "󰩫 " -- Snippet icon
        elseif source_name == "LSP" then
          return "󰒋 " -- LSP icon
        elseif source_name == "Buffer" then
          return "󰦨 " -- Buffer icon
        elseif source_name == "Path" then
          return "󰉋 " -- Path icon
        end
        return ""
      end,
      highlight = function(ctx)
        if ctx.item.source_name == "Snippets" then
          return "BlinkCmpSourceSnippets"
        end
        return "BlinkCmpSource"
      end,
    }

    return opts
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        -- Additional snippet-related keymaps
        maps.i["<C-j>"] = {
          function()
            local luasnip = require("luasnip")
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            end
          end,
          desc = "Jump to next snippet placeholder",
        }
        maps.i["<C-k>"] = {
          function()
            local luasnip = require("luasnip")
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          end,
          desc = "Jump to previous snippet placeholder",
        }
        maps.s["<C-j>"] = {
          function()
            local luasnip = require("luasnip")
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            end
          end,
          desc = "Jump to next snippet placeholder",
        }
        maps.s["<C-k>"] = {
          function()
            local luasnip = require("luasnip")
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          end,
          desc = "Jump to previous snippet placeholder",
        }
      end,
    },
    {
      "AstroNvim/astroui",
      opts = function(_, opts)
        -- Define custom highlight groups for snippets
        local get_hlgroup = require("astroui").get_hlgroup
        local normal = get_hlgroup("Normal")
        local comment = get_hlgroup("Comment")
        local string = get_hlgroup("String")
        local keyword = get_hlgroup("Keyword")
        
        opts.highlights.init = vim.tbl_deep_extend("force", opts.highlights.init or {}, {
          BlinkCmpSourceSnippets = { fg = string.fg, bold = true },
          BlinkCmpSource = { fg = comment.fg },
          LuasnipChoiceNodeActive = { fg = keyword.fg, bg = normal.bg, bold = true },
          LuasnipInsertNodeActive = { fg = string.fg, bg = normal.bg },
        })
      end,
    },
  },
}