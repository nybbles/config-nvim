return {
  "simrat39/rust-tools.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-lua/plenary.nvim",
  },
  ft = { "rust" },
  config = function()
    local has_rust_tools, rust_tools = pcall(require, "rust-tools")
    if not has_rust_tools then
      return
    end
    
    rust_tools.setup({
      tools = {
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
          parameter_hints_prefix = "← ",
          other_hints_prefix = "⇒ ",
        },
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              enable = true,
              command = "clippy",
            },
            procMacro = {
              enable = true,
            },
            cargo = {
              allFeatures = true,
            },
            inlayHints = {
              chainingHints = true,
              parameterHints = true,
              typeHints = true,
            },
          },
        },
        on_attach = function(_, bufnr)
          -- Set keymap only for Rust files
          local rt = require("rust-tools")
          
          -- Only set keymaps if the functions exist
          if rt.runnables and rt.runnables.runnables then
            vim.keymap.set("n", "<leader>rr", rt.runnables.runnables, 
              { desc = "Rust Runnables", buffer = bufnr })
          end
          
          if rt.expand_macro and rt.expand_macro.expand_macro then
            vim.keymap.set("n", "<leader>re", rt.expand_macro.expand_macro, 
              { desc = "Rust Expand Macro", buffer = bufnr })
          end
          
          vim.keymap.set("n", "<leader>rc", function() vim.cmd("e Cargo.toml") end, 
            { desc = "Open Cargo.toml", buffer = bufnr })
          
          if rt.inlay_hints and rt.inlay_hints.toggle then
            vim.keymap.set("n", "<leader>rh", rt.inlay_hints.toggle, 
              { desc = "Toggle Inlay Hints", buffer = bufnr })
          end
        end,
      },
    })
  end,
}