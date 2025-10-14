return {
  "L3MON4D3/LuaSnip",
  version = "^2.0",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          -- Visual mode snippet wrapping
          v = {
            ["<Tab>"] = {
              function()
                local ls = require("luasnip")
                if ls.choice_active() then
                  ls.change_choice(1)
                else
                  ls.expand_or_jump()
                end
              end,
              desc = "Expand snippet or jump to next placeholder",
            },
          },
        },
      },
    },
  },
  event = "InsertEnter",
  config = function()
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")
    
    -- Enhanced LuaSnip configuration
    luasnip.setup({
      -- Show current choice in choiceNodes
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "●", "DiagnosticWarn" } },
          },
        },
        [types.insertNode] = {
          active = {
            virt_text = { { "●", "DiagnosticInfo" } },
          },
        },
      },
      -- Enable autotriggered snippets
      enable_autosnippets = true,
      -- Update events for dynamic snippets
      update_events = "TextChanged,TextChangedI",
      -- Delete snippet text when jumping out of region
      delete_check_events = "TextChanged",
      -- Store snippet history for prev/next
      store_selection_keys = "<Tab>",
    })
    
    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    
    -- Load custom snippets from lua/snippets/
    require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
    
    -- Filetype extensions for related languages
    luasnip.filetype_extend("javascript", { "javascriptreact" })
    luasnip.filetype_extend("typescript", { "typescriptreact" })
    luasnip.filetype_extend("python", { "django", "pydantic" })
    luasnip.filetype_extend("rust", { "toml" })
    luasnip.filetype_extend("go", { "gomod", "gowork" })
    luasnip.filetype_extend("yaml", { "kubernetes", "helm" })
  end,
}
