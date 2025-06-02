return {
  "SmiteshP/nvim-navbuddy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
  },
  lazy = false, -- Load immediately to ensure it's available
  keys = {
    { "<leader>ln", "<cmd>Navbuddy<CR>", desc = "Navbuddy (Code Structure)" },
  },
  config = function()
    local ok, navbuddy = pcall(require, "nvim-navbuddy")
    if not ok then
      vim.notify("navbuddy failed to load", vim.log.levels.ERROR)
      return
    end
    
    -- Fixed configuration
    navbuddy.setup({
      window = {
        border = "single",
        size = "60%",
        position = "50%",
        scrolloff = 3,
      },
      lsp = {
        auto_attach = true,
        preference = nil,
      },
    })
    
    -- Forcibly connect to any active LSP client when opening
    vim.api.nvim_create_user_command("Navbuddy", function()
      local clients = vim.lsp.get_active_clients({bufnr = 0})
      if #clients == 0 then
        vim.notify("No LSP servers attached to this buffer", vim.log.levels.WARN)
        return
      end
      
      -- Find client that supports documentSymbol
      local client_id
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentSymbolProvider then
          client_id = client.id
          break
        end
      end
      
      if not client_id then
        vim.notify("No LSP server with documentSymbol capability", vim.log.levels.WARN)
        return
      end
      
      -- Open Navbuddy with the found client
      navbuddy.open({
        lsp_client = client_id
      })
    end, {})
  end
}