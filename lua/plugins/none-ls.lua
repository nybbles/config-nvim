-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    
    -- Add debouncing to reduce request cancellation errors
    config.debounce = 250
    config.default_timeout = 5000

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
      null_ls.builtins.formatting.prettierd.with({
        filetypes = { "markdown" },
        extra_args = { 
          "--prose-wrap=always", 
          "--print-width=100",
          "--tab-width=4",
          "--use-tabs=false"
        },
      }),
      null_ls.builtins.diagnostics.yamllint,
      -- null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.completion.luasnip,
      null_ls.builtins.code_actions.refactoring,
    }
    return config -- return final config table
  end,
}
