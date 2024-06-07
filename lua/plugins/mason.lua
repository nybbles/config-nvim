-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
        -- add more arguments for adding more language servers
      })
    end,
    init = function(_)
      local pylsp = require("mason-registry").get_package "python-lsp-server"
      pylsp:on("install:success", function()
        local function mason_package_path(package)
          local path = vim.fn.resolve(vim.fn.stdpath "data" .. "/mason/packages/" .. package)
          return path
        end

        local path = mason_package_path "python-lsp-server"
        local command = path .. "/venv/bin/pip"
        local args = {
          "install",
          "-U",
          "pylsp-rope",
          "python-lsp-server[rope]",
          -- "python-lsp-black",
          -- "python-lsp-isort",
          "python-lsp-ruff",
          "pyls-memestra",
          "pylsp-mypy",
        }

        require("plenary.job")
          :new({
            command = command,
            args = args,
            cwd = path,
          })
          :start()
      end)
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "prettier",
        "stylua",
        -- add more arguments for adding more null-ls sources
      })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "python",
        -- add more arguments for adding more debuggers
      })
    end,
  },
}
