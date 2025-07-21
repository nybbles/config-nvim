-- Fix for markdown nested list formatting
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.autocmds = opts.autocmds or {}
      
      -- Create autocmd group for markdown formatting
      opts.autocmds.markdown_formatting = {
        {
          event = { "FileType" },
          pattern = { "markdown" },
          desc = "Disable problematic markdown formatting options",
          callback = function()
            -- Disable vim's built-in formatting that might interfere
            vim.bo.formatoptions = vim.bo.formatoptions:gsub("[tcqron]", "")
            -- Ensure indentation is preserved
            vim.bo.autoindent = true
            vim.bo.smartindent = false
            -- Set proper indentation for lists (3 spaces for Prettier compatibility)
            vim.bo.tabstop = 3
            vim.bo.shiftwidth = 3
            vim.bo.expandtab = true
          end,
        },
      }
      
      return opts
    end,
  },
}