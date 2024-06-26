-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      -- null_ls.builtins.formatting.black,
      -- null_ls.builtins.formatting.isort.with {
      --   extra_args = { "--black", "--filter-files" },
      -- },
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.yamllint,
      -- null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.completion.luasnip,
    }
    return config -- return final config table
  end,
}
