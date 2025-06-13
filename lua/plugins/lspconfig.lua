return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "SmiteshP/nvim-navbuddy", 
    "SmiteshP/nvim-navic",
  },
  config = function()
    -- Configure Mason for LSP server installation
    local has_mason, mason = pcall(require, "mason")
    if has_mason then
      mason.setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end
    
    local has_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
    if has_mason_lsp then
      mason_lspconfig.setup({
        ensure_installed = {
          "ruff",              -- Python linting
          "rust_analyzer",     -- Rust
          "lua_ls",            -- Lua
          "bashls",            -- Bash
        },
        automatic_installation = true,
      })
    end
    
    -- Custom LSP setup
    local lspconfig = require("lspconfig")
    local has_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = has_cmp_lsp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()
    
    
    -- Additional Python linting with ruff
    lspconfig.ruff.setup({
      capabilities = capabilities,
    })
    
    -- Lua configuration
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
    
    -- Rust configuration with better parameter hints
    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
          },
          procMacro = {
            enable = true,
          },
          checkOnSave = {
            command = "clippy",
          },
          inlayHints = {
            chainingHints = true,
            parameterHints = true,
            typeHints = true,
          },
        },
      },
    })
    
    -- Bash
    lspconfig.bashls.setup({
      capabilities = capabilities,
    })
    
    -- Global LSP keymaps
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format document" })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
    vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
    vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, { desc = "Find references" })
    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover documentation" })
    vim.keymap.set("n", "<leader>ls", "<cmd>Telescope aerial<cr>", { desc = "Search symbols in file" })
    
    -- Visual mode LSP keymaps
    vim.keymap.set("v", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action (range)" })
    vim.keymap.set("v", "<leader>lf", vim.lsp.buf.format, { desc = "Format selection" })
    
    -- Setup Navbuddy if available
    local has_navbuddy, navbuddy = pcall(require, "nvim-navbuddy")
    if has_navbuddy then
      vim.keymap.set("n", "<leader>ln", "<cmd>Navbuddy<CR>", { desc = "Navigate code structure" })
    end
    
    -- Diagnostics
    vim.keymap.set("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Line diagnostics" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
    vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Add diagnostics to loclist" })
  end,
}
