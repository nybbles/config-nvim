return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    local maps = opts.mappings or {}
    
    -- Standardized LSP keybindings for all languages
    maps.n = vim.tbl_deep_extend("keep", maps.n or {}, {
      -- Which-key group definitions
      ["<leader>l"] = { desc = "󰒋 LSP" },
      ["<leader>lw"] = { desc = " Workspace" },
      
      -- Core LSP actions (consistent across all languages)
      ["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "Code Actions" },
      ["<leader>lf"] = { function() vim.lsp.buf.format({ async = true }) end, desc = "Format Document" },
      ["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "Rename Symbol" },
      ["<leader>lh"] = { function() vim.lsp.buf.hover() end, desc = "Hover Documentation" },
      ["<leader>ls"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature Help" },
      
      -- Navigation (consistent across all languages)
      ["<leader>ld"] = { function() vim.lsp.buf.definition() end, desc = "Go to Definition" },
      ["<leader>lD"] = { function() vim.lsp.buf.declaration() end, desc = "Go to Declaration" },
      ["<leader>li"] = { function() vim.lsp.buf.implementation() end, desc = "Go to Implementation" },
      ["<leader>lt"] = { function() vim.lsp.buf.type_definition() end, desc = "Go to Type Definition" },
      ["<leader>lR"] = { function() vim.lsp.buf.references() end, desc = "Find References" },
      
      -- Diagnostics (consistent across all languages)
      ["<leader>le"] = { function() vim.diagnostic.open_float() end, desc = "Show Diagnostics" },
      ["<leader>lj"] = { function() vim.diagnostic.goto_next() end, desc = "Next Diagnostic" },
      ["<leader>lp"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous Diagnostic" },
      ["<leader>lq"] = { function() vim.diagnostic.setloclist() end, desc = "Diagnostic Quickfix" },
      
      -- Workspace (consistent across all languages)
      ["<leader>lwa"] = { function() vim.lsp.buf.add_workspace_folder() end, desc = "Add Workspace Folder" },
      ["<leader>lwr"] = { function() vim.lsp.buf.remove_workspace_folder() end, desc = "Remove Workspace Folder" },
      ["<leader>lwl"] = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, desc = "List Workspace Folders" },
      
      -- Toggle features
      ["<leader>uD"] = { function() 
        local enabled = vim.diagnostic.is_disabled()
        if enabled then
          vim.diagnostic.enable()
          vim.notify("Diagnostics enabled", vim.log.levels.INFO)
        else
          vim.diagnostic.disable()
          vim.notify("Diagnostics disabled", vim.log.levels.INFO)
        end
      end, desc = "Toggle Diagnostics" },
      
      ["<leader>uh"] = { function()
        local enabled = vim.lsp.inlay_hint.is_enabled()
        vim.lsp.inlay_hint.enable(not enabled)
        vim.notify(enabled and "Inlay hints disabled" or "Inlay hints enabled", vim.log.levels.INFO)
      end, desc = "Toggle Inlay Hints" },
    })
    
    -- Visual mode code actions
    maps.v = vim.tbl_deep_extend("keep", maps.v or {}, {
      ["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "Code Actions (Range)" },
      ["<leader>lf"] = { function() vim.lsp.buf.format({ async = true }) end, desc = "Format Selection" },
    })
    
    -- Language-specific enhancements
    -- Rust-specific keybindings
    maps.n["<leader>r"] = { desc = "🦀 Rust" }
    maps.n["<leader>ra"] = { function() 
      if vim.bo.filetype == "rust" then
        vim.cmd.RustLsp('codeAction')
      else 
        vim.lsp.buf.code_action() 
      end 
    end, desc = "Rust Code Actions" }
    maps.n["<leader>rr"] = { function() vim.cmd.RustLsp('runnables') end, desc = "Rust Runnables" }
    maps.n["<leader>rt"] = { function() vim.cmd.RustLsp('testables') end, desc = "Rust Tests" }
    maps.n["<leader>rm"] = { function() vim.cmd.RustLsp('expandMacro') end, desc = "Expand Macro" }
    maps.n["<leader>rc"] = { function() vim.cmd("e Cargo.toml") end, desc = "Open Cargo.toml" }
    maps.n["<leader>rd"] = { function() vim.cmd.RustLsp('renderDiagnostic') end, desc = "Render Diagnostic" }
    maps.n["<leader>rh"] = { function() vim.cmd.RustLsp('hover') end, desc = "Rust Hover Actions" }
    
    -- Python-specific keybindings  
    maps.n["<leader>p"] = { desc = "🐍 Python" }
    maps.n["<leader>pa"] = { function() vim.lsp.buf.code_action() end, desc = "Python Code Actions" }
    maps.n["<leader>pi"] = { function() 
      -- Trigger organize imports code action
      vim.lsp.buf.code_action({
        filter = function(action)
          return action.title:match("Organize imports") or action.title:match("Import")
        end,
        apply = true,
      })
    end, desc = "Organize Imports" }
    maps.n["<leader>pr"] = { function()
      -- Trigger refactoring code actions
      vim.lsp.buf.code_action({
        filter = function(action)
          return action.title:match("Refactor") or action.title:match("Extract")
        end,
      })
    end, desc = "Refactoring Actions" }
    maps.n["<leader>pt"] = { function()
      -- Try to run tests (depends on your test runner)
      local test_runners = { "pytest", "python -m pytest", "python -m unittest" }
      for _, runner in ipairs(test_runners) do
        if vim.fn.executable(runner:match("^%S+")) == 1 then
          vim.cmd("!" .. runner)
          break
        end
      end
    end, desc = "Run Tests" }
    
    -- Remove conflicting/redundant keybindings
    maps.n["<leader>lc"] = nil -- Remove duplicate code action binding
    maps.n["<leader>lG"] = nil -- Already disabled in astrolsp.lua
    
    return opts
  end,
}