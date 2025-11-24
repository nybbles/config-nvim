return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        rust_help_setup = {
          {
            event = "FileType", 
            pattern = "rust",
            desc = "Setup Rust documentation and help keymaps",
            callback = function(args)
              local bufnr = args.buf
              
              -- Function to open rustc error explanation
              local function rustc_explain()
                vim.ui.input({ prompt = "Enter Rust error code (e.g., E0277): " }, function(error_code)
                  if not error_code or error_code == "" then
                    vim.notify("No error code provided", vim.log.levels.WARN)
                    return
                  end
                  
                  -- Clean up the error code format
                  error_code = error_code:match("E%d+") or error_code
                  
                  vim.cmd("split")
                  local buf = vim.api.nvim_create_buf(false, true)
                  vim.api.nvim_win_set_buf(0, buf)
                  vim.bo[buf].filetype = "markdown"
                  vim.bo[buf].buftype = "nofile"
                  vim.bo[buf].bufhidden = "wipe"
                  
                  -- Set buffer name for better identification
                  vim.api.nvim_buf_set_name(buf, string.format("rustc-explain-%s", error_code))
                  
                  local job_id = vim.fn.jobstart({"rustc", "--explain", error_code}, {
                    stdout_buffered = true,
                    on_stdout = function(_, data)
                      if data and #data > 0 then
                        -- Filter out empty lines at the end
                        while #data > 0 and data[#data] == "" do
                          table.remove(data)
                        end
                        if #data > 0 then
                          vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
                        end
                      end
                    end,
                    on_stderr = function(_, data)
                      if data and #data > 0 and data[1] ~= "" then
                        local error_msg = table.concat(data, "\n")
                        vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
                          "# Error",
                          "",
                          "Could not find explanation for error code: " .. error_code,
                          "",
                          "Error details:",
                          error_msg
                        })
                      end
                    end,
                    on_exit = function(_, exit_code)
                      if exit_code ~= 0 then
                        vim.schedule(function()
                          vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
                            "# Error",
                            "",
                            "Could not find explanation for error code: " .. error_code,
                            "",
                            "Make sure the error code is valid (e.g., E0277, E0308, etc.)"
                          })
                        end)
                      end
                    end
                  })
                  
                  if job_id == 0 or job_id == -1 then
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
                      "# Error",
                      "",
                      "Could not start rustc --explain command.",
                      "Make sure rustc is installed and in your PATH."
                    })
                  end
                end)
              end
              
              -- Function to search Rust documentation
              local function rust_doc_search()
                local word = vim.fn.expand("<cword>")
                if word == "" then
                  vim.ui.input({ prompt = "Search Rust docs for: " }, function(search_term)
                    if search_term and search_term ~= "" then
                      vim.fn.system(string.format("open 'https://doc.rust-lang.org/std/?search=%s'", vim.uri_encode(search_term)))
                    end
                  end)
                else
                  -- Open Rust documentation for the word under cursor
                  vim.fn.system(string.format("open 'https://doc.rust-lang.org/std/?search=%s'", vim.uri_encode(word)))
                end
              end
              
              -- Function to open Rust reference
              local function rust_reference()
                vim.fn.system("open 'https://doc.rust-lang.org/reference/'")
              end
              
              -- Function to open Rust book
              local function rust_book()
                vim.fn.system("open 'https://doc.rust-lang.org/book/'")
              end
              
              -- Function to show common Rust error codes
              local function rust_error_codes()
                local common_errors = {
                  "E0277 - trait bound not satisfied",
                  "E0308 - mismatched types", 
                  "E0382 - use of moved value",
                  "E0384 - cannot assign twice to immutable variable",
                  "E0425 - cannot find value in this scope",
                  "E0433 - failed to resolve: use of undeclared type",
                  "E0499 - cannot borrow as mutable more than once",
                  "E0502 - cannot borrow as immutable because it's also borrowed as mutable",
                  "E0507 - cannot move out of borrowed content",
                  "E0596 - cannot borrow as mutable",
                }
                
                vim.ui.select(common_errors, {
                  prompt = "Select error code to explain:",
                  format_item = function(item)
                    return item
                  end,
                }, function(choice)
                  if choice then
                    local error_code = choice:match("(E%d+)")
                    if error_code then
                      vim.cmd("split")
                      local buf = vim.api.nvim_create_buf(false, true)
                      vim.api.nvim_win_set_buf(0, buf)
                      vim.bo[buf].filetype = "markdown"
                      vim.bo[buf].buftype = "nofile"
                      vim.bo[buf].bufhidden = "wipe"
                      vim.api.nvim_buf_set_name(buf, string.format("rustc-explain-%s", error_code))
                      
                      vim.fn.jobstart({"rustc", "--explain", error_code}, {
                        stdout_buffered = true,
                        on_stdout = function(_, data)
                          if data and #data > 0 then
                            while #data > 0 and data[#data] == "" do
                              table.remove(data)
                            end
                            if #data > 0 then
                              vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
                            end
                          end
                        end,
                      })
                    end
                  end
                end)
              end
              
              -- Set up keymaps for Rust documentation and help
              vim.keymap.set("n", "<leader>rE", rustc_explain, 
                { desc = "Explain Rust error code", buffer = bufnr })
                
              vim.keymap.set("n", "<leader>rD", rust_doc_search, 
                { desc = "Search Rust documentation", buffer = bufnr })
                
              vim.keymap.set("n", "<leader>rR", rust_reference, 
                { desc = "Open Rust Reference", buffer = bufnr })
                
              vim.keymap.set("n", "<leader>rB", rust_book, 
                { desc = "Open Rust Book", buffer = bufnr })
                
              vim.keymap.set("n", "<leader>rC", rust_error_codes, 
                { desc = "Common Rust error codes", buffer = bufnr })
            end,
          },
        },
      },
    },
  },
}