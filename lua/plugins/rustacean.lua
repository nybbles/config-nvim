return {
  "mrcjkb/rustaceanvim",
  version = "^5", -- Recommended
  lazy = false, -- This plugin is already lazy
  ft = { "rust" },
  enabled = true,
  config = function()
    -- rustaceanvim is configured via vim.g.rustaceanvim
    -- Get capabilities from blink.cmp if available
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local has_blink, blink = pcall(require, "blink.cmp")
    if has_blink then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end
    
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        -- Enable/disable automatic creation of Cargo.toml commands 
        enable_nextest = true,
        enable_clippy = true,
        -- Automatically set inlay hints (type hints)
        inlay_hints = {
          auto = true,
          only_current_line = false,
          show_parameter_hints = true,
          parameter_hints_prefix = "← ",
          other_hints_prefix = "⇒ ",
          max_len_align = false,
          max_len_align_padding = 1,
          right_align = false,
          right_align_padding = 7,
          highlight = "Comment",
        },
        hover_actions = {
          border = "rounded",
        },
        crate_graph = {
          backend = "x11",
          output = nil,
          full = true,
        },
      },
      -- LSP configuration
      server = {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              enable = true,
              command = "clippy",
              allFeatures = true,
            },
            procMacro = {
              enable = true,
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Enhanced assists for code actions
            assist = {
              importGranularity = "module",
              importEnforceGranularity = true,
              importPrefix = "self",
              expressionFillDefault = "default",
            },
            -- Enhanced diagnostics and compiler help
            diagnostics = {
              enable = true,
              enableExperimental = true,
              disabled = {},
              warningsAsHint = {},
              warningsAsInfo = {},
            },
            hover = {
              actions = {
                enable = true,
                implementations = {
                  enable = true,
                },
                references = {
                  enable = true,
                },
                run = {
                  enable = true,
                },
                debug = {
                  enable = true,
                },
              },
              documentation = {
                enable = true,
                keywords = {
                  enable = true,
                },
              },
            },
            completion = {
              addCallParenthesis = true,
              addCallArgumentSnippets = true,
              postfix = {
                enable = true,
              },
              privateEditable = {
                enable = true,
              },
              callable = {
                snippets = "add_parentheses",
              },
            },
            -- Enhanced code actions and refactoring
            experimental = {
              procAttrMacros = true,
            },
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "self",
            },
            -- Enable lens for more code actions
            lens = {
              enable = true,
              implementations = {
                enable = true,
              },
              references = {
                adt = {
                  enable = true,
                },
                enumVariant = {
                  enable = true,
                },
                method = {
                  enable = true,
                },
                trait = {
                  enable = true,
                },
              },
              run = {
                enable = true,
              },
              debug = {
                enable = true,
              },
            },
            -- Inlay hints
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "never",
              },
              lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "never",
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
          },
        },
        on_attach = function(client, bufnr)
          -- Enable format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
          
          -- Function to explain Rust compiler errors
          local function explain_error()
            -- Get diagnostics at cursor position
            local line = vim.api.nvim_win_get_cursor(0)[1] - 1
            local diagnostics = vim.diagnostic.get(bufnr, { lnum = line })
            
            if #diagnostics == 0 then
              vim.notify("No diagnostics found at cursor position", vim.log.levels.WARN)
              return
            end
            
            local diagnostic = diagnostics[1]
            if diagnostic.code and type(diagnostic.code) == "string" and diagnostic.code:match("^E%d+") then
              -- For rustc error codes, try to use rustc --explain
              local error_code = diagnostic.code
              vim.cmd("split")
              local buf = vim.api.nvim_create_buf(false, true)
              vim.api.nvim_win_set_buf(0, buf)
              vim.bo[buf].filetype = "markdown"
              vim.bo[buf].buftype = "nofile"
              
              local job_id = vim.fn.jobstart({"rustc", "--explain", error_code}, {
                stdout_buffered = true,
                on_stdout = function(_, data)
                  if data then
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
                  end
                end,
                on_stderr = function(_, data)
                  if data and #data > 0 and data[1] ~= "" then
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {"Error: " .. table.concat(data, "\n")})
                  end
                end
              })
              
              if job_id == 0 or job_id == -1 then
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, {"Error: Could not start rustc --explain command"})
              end
            else
              -- For other diagnostics, show detailed message in floating window
              local message = diagnostic.message or "No message available"
              if diagnostic.code then
                message = string.format("Code: %s\n\n%s", diagnostic.code, message)
              end
              
              vim.lsp.util.open_floating_preview({message}, "markdown", {
                border = "rounded",
                max_width = 80,
                max_height = 20,
                wrap = true,
                focusable = true,
              })
            end
          end
          
          -- Keymaps using rustaceanvim commands
          vim.keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp('runnables') end, 
            { desc = "Rust Runnables", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>rt", function() vim.cmd.RustLsp('testables') end, 
            { desc = "Rust Testables", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>rm", function() vim.cmd.RustLsp('expandMacro') end, 
            { desc = "Rust Expand Macro", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp('renderDiagnostic') end, 
            { desc = "Rust Render Diagnostic", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>re", explain_error, 
            { desc = "Explain Rust Error", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>rc", function() vim.cmd("e Cargo.toml") end, 
            { desc = "Open Cargo.toml", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>rh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, 
            { desc = "Toggle Inlay Hints", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp('parentModule') end, 
            { desc = "Rust Parent Module", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>rj", function() vim.cmd.RustLsp('joinLines') end, 
            { desc = "Rust Join Lines", buffer = bufnr })
          
          vim.keymap.set("n", "<leader>ra", function() vim.cmd.RustLsp('codeAction') end, 
            { desc = "Rust Code Action", buffer = bufnr })
        end,
      },
      -- DAP configuration
      dap = {
        adapter = {
          type = 'executable',
          command = 'lldb-dap', -- Use lldb-dap for better Rust debugging
          name = 'rt_lldb',
        },
      },
    }
  end,
}