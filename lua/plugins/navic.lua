return {
  "SmiteshP/nvim-navic",
  dependencies = {
    "neovim/nvim-lspconfig"
  },
  event = "LspAttach",
  opts = {
    icons = {
      File = " ",
      Module = " ",
      Namespace = " ",
      Package = " ",
      Class = " ",
      Method = " ",
      Property = " ",
      Field = " ",
      Constructor = " ",
      Enum = " ",
      Interface = " ",
      Function = " ",
      Variable = " ",
      Constant = " ",
      String = " ",
      Number = " ",
      Boolean = " ",
      Array = " ",
      Object = " ",
      Key = " ",
      Null = " ",
      EnumMember = " ",
      Struct = " ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
    },
    lsp = {
      auto_attach = true,
    },
    highlight = true,
    separator = " › ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    safe_output = true,
    click = false,
  },
  config = function(_, opts)
    require("nvim-navic").setup(opts)
    
    -- Set up autocmd to display breadcrumbs in winbar if navic is available
    local set_winbar = function()
      if vim.api.nvim_eval_statusline("%f", {}).width > 70 then
        -- Filename is too long, don't show NavIC
        vim.opt_local.winbar = "%f"
        return
      end
      
      local navic = require("nvim-navic")
      if navic.is_available() then
        -- Show both filename and navic breadcrumbs
        vim.opt_local.winbar = "%f %{%v:lua.require'nvim-navic'.get_location()%}"
      else
        -- Just show filename if navic not available for this buffer
        vim.opt_local.winbar = "%f"
      end
    end
    
    -- Update winbar when things change
    vim.api.nvim_create_autocmd({
      "BufEnter", 
      "CursorMoved", 
      "InsertLeave",
      "BufWinEnter",
      "LspAttach",
    }, {
      callback = function()
        -- Only enable navic breadcrumbs for programming languages
        local filetype = vim.bo.filetype
        if filetype == "rust" or filetype == "python" or filetype == "lua" or 
           filetype == "javascript" or filetype == "typescript" or 
           filetype == "c" or filetype == "cpp" or filetype == "go" then
          pcall(set_winbar)
        end
      end,
    })
  end
}