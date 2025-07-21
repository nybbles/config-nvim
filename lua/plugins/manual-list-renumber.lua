-- Manual list renumbering function as backup
return {
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.mappings = opts.mappings or {}
      opts.mappings.n = opts.mappings.n or {}
      
      -- Add manual list renumbering function
      opts.mappings.n["<leader>mR"] = {
        function()
          -- Get current buffer
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          local cursor_pos = vim.api.nvim_win_get_cursor(0)
          local modified_lines = {}
          local in_list = false
          local list_number = 1
          local list_indent = ""
          
          for i, line in ipairs(lines) do
            -- Check if line is a numbered list item
            local indent, num, rest = line:match("^(%s*)(%d+)%.%s(.*)$")
            if indent and num and rest then
              if not in_list or indent == list_indent then
                -- Start of new list or continuation of same level
                if not in_list then
                  list_number = 1
                  list_indent = indent
                  in_list = true
                else
                  list_number = list_number + 1
                end
              elseif #indent > #list_indent then
                -- Nested list - start new numbering
                list_number = 1
                list_indent = indent
              elseif #indent < #list_indent then
                -- Back to higher level - need to track multiple levels
                -- For now, just reset to 1
                list_number = 1
                list_indent = indent
              end
              
              -- Replace with correct number
              modified_lines[i] = indent .. list_number .. ". " .. rest
            else
              -- Not a numbered list item
              if line:match("^%s*$") then
                -- Empty line - don't reset list state
                modified_lines[i] = line
              else
                -- Non-list line - reset list state
                in_list = false
                modified_lines[i] = line
              end
            end
          end
          
          -- Apply changes to buffer
          local changed = false
          for i, new_line in pairs(modified_lines) do
            if new_line ~= lines[i] then
              vim.api.nvim_buf_set_lines(0, i-1, i, false, {new_line})
              changed = true
            end
          end
          
          if changed then
            print("List renumbered!")
          else
            print("No numbered lists found")
          end
        end,
        desc = "Manually renumber markdown lists"
      }
      
      return opts
    end,
  },
}