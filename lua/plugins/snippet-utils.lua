-- Snippet utilities and enhancements
return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        
        -- Add utility keymaps for snippet management
        maps.n["<Leader>ss"] = {
          function()
            local luasnip = require("luasnip")
            -- Reload all snippets
            luasnip.cleanup()
            require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
            vim.notify("Snippets reloaded!", vim.log.levels.INFO)
          end,
          desc = "Reload snippets",
        }
        
        maps.n["<Leader>sl"] = {
          function()
            -- List available snippets for current filetype
            local luasnip = require("luasnip")
            local ft = vim.bo.filetype
            local snippets = luasnip.get_snippets(ft, { type = "snippets" })
            
            if not snippets or #snippets == 0 then
              vim.notify("No snippets available for filetype: " .. ft, vim.log.levels.WARN)
              return
            end
            
            local items = {}
            for _, snippet in ipairs(snippets) do
              table.insert(items, {
                trigger = snippet.trigger,
                description = snippet.dscr or snippet.name or "No description",
                snippet = snippet
              })
            end
            
            -- Sort by trigger name
            table.sort(items, function(a, b) return a.trigger < b.trigger end)
            
            -- Create a simple picker
            local lines = {}
            for i, item in ipairs(items) do
              table.insert(lines, string.format("%2d. %-15s %s", i, item.trigger, item.description))
            end
            
            -- Open in a new buffer
            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.api.nvim_buf_set_name(buf, "Snippets for " .. ft)
            vim.api.nvim_buf_set_option(buf, "filetype", "snippets-list")
            vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
            vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
            
            -- Open in a floating window
            local width = math.min(80, vim.o.columns - 4)
            local height = math.min(#lines + 2, vim.o.lines - 4)
            local win = vim.api.nvim_open_win(buf, true, {
              relative = "editor",
              width = width,
              height = height,
              col = math.floor((vim.o.columns - width) / 2),
              row = math.floor((vim.o.lines - height) / 2),
              border = "rounded",
              title = " Snippets for " .. ft .. " ",
              title_pos = "center",
            })
            
            -- Set window options
            vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal,FloatBorder:FloatBorder")
            
            -- Add keymap to close window
            vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = buf, desc = "Close snippets list" })
            vim.keymap.set("n", "<Esc>", "<cmd>q<cr>", { buffer = buf, desc = "Close snippets list" })
          end,
          desc = "List available snippets",
        }
        
        maps.n["<Leader>se"] = {
          function()
            -- Edit snippets file for current filetype
            local ft = vim.bo.filetype
            if ft == "" then
              vim.notify("No filetype detected", vim.log.levels.WARN)
              return
            end
            
            local snippets_dir = vim.fn.stdpath("config") .. "/lua/snippets"
            local snippet_file = snippets_dir .. "/" .. ft .. ".lua"
            
            -- Create directory if it doesn't exist
            vim.fn.mkdir(snippets_dir, "p")
            
            -- Create basic snippet file template if it doesn't exist
            if vim.fn.filereadable(snippet_file) == 0 then
              local template = {
                'local ls = require("luasnip")',
                'local s = ls.snippet',
                'local t = ls.text_node',
                'local i = ls.insert_node',
                'local fmt = require("luasnip.extras.fmt").fmt',
                '',
                'return {',
                '  -- Add your ' .. ft .. ' snippets here',
                '  s("example", fmt("Hello {}!", { i(1, "world") })),',
                '}'
              }
              vim.fn.writefile(template, snippet_file)
            end
            
            vim.cmd("edit " .. snippet_file)
          end,
          desc = "Edit snippets for current filetype",
        }
        
        -- Visual mode snippet creation helper
        maps.x["<Leader>sc"] = {
          function()
            -- Create snippet from selected text
            local start_pos = vim.fn.getpos("'<")
            local end_pos = vim.fn.getpos("'>")
            
            -- Get selected text
            local lines = vim.fn.getline(start_pos[2], end_pos[2])
            if #lines == 0 then return end
            
            -- Handle single line selection
            if #lines == 1 then
              lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
            else
              -- Handle multi-line selection
              lines[1] = string.sub(lines[1], start_pos[3])
              lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
            end
            
            local selected_text = table.concat(lines, "\n")
            
            -- Create snippet template
            local trigger = vim.fn.input("Snippet trigger: ")
            if trigger == "" then return end
            
            local description = vim.fn.input("Snippet description: ")
            if description == "" then description = "Generated snippet" end
            
            -- Basic snippet template
            local snippet_code = string.format(
              's("%s", fmt([[\n%s\n]], {\n  %s\n})),',
              trigger,
              selected_text:gsub("%%", "%%%%"),  -- Escape % characters
              "-- Add placeholders here: i(1, \"placeholder\")"
            )
            
            vim.notify("Snippet template created! Use <Leader>se to edit snippets file.", vim.log.levels.INFO)
            
            -- Copy to clipboard
            vim.fn.setreg("+", snippet_code)
            vim.notify("Snippet template copied to clipboard", vim.log.levels.INFO)
          end,
          desc = "Create snippet from selection",
        }
        
        return opts
      end,
    },
  },
  config = function()
    -- Add custom snippet highlight groups
    vim.api.nvim_set_hl(0, "LuaSnipChoice", { fg = "#FFD700", bold = true })
    vim.api.nvim_set_hl(0, "LuaSnipInsert", { fg = "#87CEEB", bold = true })
    
    -- Auto-reload snippets when editing snippet files
    local snippet_group = vim.api.nvim_create_augroup("SnippetUtils", { clear = true })
    
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = snippet_group,
      pattern = vim.fn.stdpath("config") .. "/lua/snippets/*.lua",
      callback = function()
        local luasnip = require("luasnip")
        -- Clear and reload snippets
        luasnip.cleanup()
        require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
        vim.notify("Snippets reloaded automatically", vim.log.levels.INFO)
      end,
      desc = "Auto-reload snippets on save",
    })
    
    -- Show snippet info in completion menu (if using nvim-cmp fallback)
    vim.api.nvim_create_autocmd("FileType", {
      group = snippet_group,
      pattern = "*",
      callback = function()
        local ft = vim.bo.filetype
        if ft == "" then return end
        
        -- Set buffer-local completion options to show more snippet info
        if vim.fn.exists("b:snippet_loaded") == 0 then
          vim.b.snippet_loaded = 1
          
          -- Only show notification once per session per filetype
          local notified_key = "snippet_loaded_" .. ft
          if not vim.g[notified_key] then
            vim.g[notified_key] = true
            
            local luasnip = require("luasnip")
            local snippets = luasnip.get_snippets(ft, { type = "snippets" })
            if snippets and #snippets > 0 then
              vim.defer_fn(function()
                vim.notify(
                  string.format("💡 %d snippets available for %s. Use <Leader>sl to list them.", #snippets, ft),
                  vim.log.levels.INFO,
                  { timeout = 3000 }
                )
              end, 1000)
            end
          end
        end
      end,
    })
  end,
}