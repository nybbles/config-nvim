return {
  "danymat/neogen",
  config = function(plugin, opts) require("neogen").setup { snippet_engine = "luasnip" } end,
}
