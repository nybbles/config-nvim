return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "Saghen/blink.cmp" },
  config = function()
    local autopairs = require("nvim-autopairs")
    
    autopairs.setup({
      check_ts = true, -- treesitter integration
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false, -- don't check treesitter on java
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      disable_in_macro = false,
      disable_in_visualblock = false,
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,
      enable_check_bracket_line = true,
      enable_bracket_in_quote = true,
      enable_abbr = false,
      break_undo = true,
      check_comma = true,
      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false,
    })

    -- Integration with blink.cmp
    local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
    if blink_cmp_ok then
      -- Set up autopairs with blink.cmp
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpAccept",
        callback = function()
          local autopairs_ok, autopairs_cmp = pcall(require, "nvim-autopairs.completion.blink")
          if autopairs_ok then
            autopairs_cmp.on_confirm_done()
          end
        end,
      })
    end
    
    -- Custom rules for Rust
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")
    
    -- Add spaces in Rust function calls and generics
    autopairs.add_rules({
      Rule(" ", " ")
        :with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({ "()", "[]", "{}" }, pair)
        end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
          local col = vim.api.nvim_win_get_cursor(0)[2]
          local context = opts.line:sub(col - 1, col + 2)
          return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, context)
        end),
        
      -- Rust lifetime parameters
      Rule("'", "'", "rust")
        :with_pair(cond.not_after_regex("[%w]"))
        :with_pair(cond.not_before_regex("'", 1)),
        
      -- Rust macro rules
      Rule("$", "$", "rust")
        :with_pair(cond.not_after_regex("[%w]"))
        :with_pair(cond.not_before_regex("$", 1)),
    })
  end,
}
