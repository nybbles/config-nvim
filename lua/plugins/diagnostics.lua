return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      diagnostics = {
        -- Configure diagnostic display settings
        virtual_text = {
          -- Show virtual text with diagnostic messages
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- Enhanced format for Rust diagnostics
          format = function(diagnostic)
            local message = diagnostic.message
            if diagnostic.source == "rust-analyzer" and diagnostic.code then
              -- Show error code for rust-analyzer diagnostics
              message = string.format("[%s] %s", diagnostic.code, message)
            end
            return message
          end,
        },
        signs = {
          -- Use custom signs for better visibility
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "▲",
            [vim.diagnostic.severity.HINT] = "⚑",
            [vim.diagnostic.severity.INFO] = "●",
          },
        },
        update_in_insert = false, -- Don't update diagnostics in insert mode
        underline = true,
        severity_sort = true,
        float = {
          -- Enhanced floating window for diagnostics
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          -- Custom format for floating diagnostics
          format = function(diagnostic)
            local message = diagnostic.message
            local source = diagnostic.source or "Unknown"
            local code = diagnostic.code and string.format(" [%s]", diagnostic.code) or ""
            
            -- For rust-analyzer, provide more detailed formatting
            if source == "rust-analyzer" then
              local header = string.format("rust-analyzer%s", code)
              return string.format("%s\n%s", header, message)
            end
            
            return string.format("%s%s: %s", source, code, message)
          end,
        },
      },
      -- Autocmds for enhanced diagnostic experience
      autocmds = {
        diagnostic_config = {
          {
            event = "FileType",
            pattern = "rust",
            desc = "Enhanced Rust diagnostic configuration",
            callback = function(args)
              -- Set buffer-local diagnostic configuration for Rust
              -- Ensure we have a valid buffer
              if not args.buf or not vim.api.nvim_buf_is_valid(args.buf) then
                return
              end
              vim.diagnostic.config({
                virtual_text = {
                  spacing = 4,
                  source = "always",
                  prefix = "●",
                  suffix = "",
                  format = function(diagnostic)
                    local message = diagnostic.message
                    if diagnostic.code then
                      -- For Rust, show the error code prominently
                      message = string.format("[%s] %s", diagnostic.code, message)
                    end
                    -- Truncate very long messages for virtual text
                    if #message > 80 then
                      message = message:sub(1, 77) .. "..."
                    end
                    return message
                  end,
                },
                float = {
                  border = "rounded",
                  source = "always",
                  header = "Diagnostic Information:",
                  prefix = " ",
                  suffix = "",
                  focusable = true,
                  max_width = 100,
                  max_height = 30,
                  wrap = true,
                },
              })
            end,
          },
        },
      },
      -- Enhanced mappings for diagnostics
      mappings = {
        n = {
          -- Override default diagnostic mappings for better Rust experience
          ["gl"] = {
            function()
              vim.diagnostic.open_float({
                border = "rounded",
                source = "always",
                header = "Diagnostic Details:",
                prefix = " ",
                focusable = true,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
              })
            end,
            desc = "Show diagnostic in floating window",
          },
          ["[d"] = {
            function()
              vim.diagnostic.goto_prev({
                float = {
                  border = "rounded",
                  source = "always",
                  header = "Previous Diagnostic:",
                  prefix = " ",
                },
              })
            end,
            desc = "Previous diagnostic with details",
          },
          ["]d"] = {
            function()
              vim.diagnostic.goto_next({
                float = {
                  border = "rounded",
                  source = "always", 
                  header = "Next Diagnostic:",
                  prefix = " ",
                },
              })
            end,
            desc = "Next diagnostic with details",
          },
          ["<Leader>dd"] = {
            function()
              vim.diagnostic.setloclist()
            end,
            desc = "Add diagnostics to location list",
          },
        },
      },
    },
  },
}