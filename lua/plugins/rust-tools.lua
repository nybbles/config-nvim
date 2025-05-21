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
          vim.keymap.set("n", "<leader>rr", rust_tools.runnables.runnables, 
            { desc = "Rust Runnables", buffer = bufnr })
          vim.keymap.set("n", "<leader>re", rust_tools.expand_macro.expand_macro, 
            { desc = "Rust Expand Macro", buffer = bufnr })
          vim.keymap.set("n", "<leader>rc", function() vim.cmd("e Cargo.toml") end, 
            { desc = "Open Cargo.toml", buffer = bufnr })
          vim.keymap.set("n", "<leader>rh", rust_tools.inlay_hints.toggle, 
            { desc = "Toggle Inlay Hints", buffer = bufnr })
        end,
      },
    })
  end,
}