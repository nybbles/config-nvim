-- Markdown paragraph formatting utilities
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.mappings = opts.mappings or {}
      opts.mappings.n = opts.mappings.n or {}
      
      -- Add keybinding to format current paragraph
      opts.mappings.n["gqp"] = {
        function()
          -- Save cursor position
          local cursor = vim.api.nvim_win_get_cursor(0)
          local line = cursor[1]
          local col = cursor[2]
          
          -- Use vim's built-in paragraph formatting
          vim.cmd("normal! gqip")
          
          -- Try to restore cursor position
          pcall(vim.api.nvim_win_set_cursor, 0, {line, col})
        end,
        desc = "Format paragraph",
      }
      
      -- Alternative: Use prettier for current paragraph
      opts.mappings.n["<leader>mp"] = {
        function()
          -- Save current position
          local cursor = vim.api.nvim_win_get_cursor(0)
          
          -- Select inner paragraph
          vim.cmd("normal! vip")
          
          -- Get the visual selection range
          local start_pos = vim.fn.getpos("'<")
          local end_pos = vim.fn.getpos("'>")
          local start_line = start_pos[2]
          local end_line = end_pos[2]
          
          -- Exit visual mode
          vim.cmd("normal! ")
          
          -- Format with prettier
          vim.cmd(start_line .. "," .. end_line .. "!prettier --stdin-filepath temp.md --print-width 100 --prose-wrap always")
          
          -- Try to restore cursor position
          pcall(vim.api.nvim_win_set_cursor, 0, cursor)
        end,
        desc = "Format paragraph with prettier",
      }
      
      -- Auto-format on certain triggers (optional - can be enabled if desired)
      opts.autocmds = opts.autocmds or {}
      opts.autocmds.markdown_autoformat = {
        {
          event = "FileType",
          pattern = "markdown",
          desc = "Set up markdown formatting options",
          callback = function()
            -- Set text width for automatic line breaking
            vim.opt_local.textwidth = 100
            -- Clear existing formatoptions and set exactly what we want
            vim.opt_local.formatoptions = "tcqwan"
            -- t = auto-wrap text using textwidth
            -- c = auto-wrap comments using textwidth
            -- q = allow formatting of comments with "gq"
            -- w = trailing white space indicates a paragraph continues
            -- a = automatic formatting of paragraphs (reflow as you type)
            -- n = recognize numbered lists
          end,
        },
      }
      
      return opts
    end,
  },
}