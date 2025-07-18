return {
  "L3MON4D3/LuaSnip",
  lazy = true,
  event = "InsertEnter", -- Load only when entering insert mode
  config = function(plugin, opts)
    require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
    -- add more custom luasnip configuration such as filetype extend or custom snippets
    local luasnip = require "luasnip"
    luasnip.filetype_extend("javascript", { "javascriptreact" })
  end,
}
