-- DISABLED for AstroNvim v5: telescope is replaced by snacks.nvim
if true then return {} end -- DISABLE: telescope replaced by snacks.nvim in v5

return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  cmd = "Telescope",
  keys = {
    { "<leader>f", desc = "Find" },
    { "<leader>l", desc = "LSP" },
    { "<leader>s", desc = "Search" },
  },
  dependencies = {
    "folke/trouble.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "-u",
      },
      file_ignore_patterns = {
        ".git",
        "node_modules",
        ".venv",
      },
      mappings = {
        i = { ["c-t"] = open_with_trouble },
      },
    },
  },

  config = function(plugin, opts)
    local telescope = require "telescope"
    local trouble_open = require("trouble.sources.telescope").open

    local open_with_trouble = function(prompt_bufnr)
      opts = {
        win = { position = "right" },
      }
      return trouble_open(prompt_bufnr, opts)
    end

    opts.defaults.mappings = {
      i = { ["<c-t>"] = open_with_trouble },
      n = { ["<c-t>"] = open_with_trouble },
    }

    telescope.setup(opts)
    
    -- Configure file browser with proper keybindings
    telescope.setup({
      extensions = {
        file_browser = {
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<C-d>"] = require("telescope._extensions.file_browser.actions").remove,
              ["<C-r>"] = require("telescope._extensions.file_browser.actions").rename,
              ["<C-y>"] = require("telescope._extensions.file_browser.actions").copy,
              ["<C-n>"] = require("telescope._extensions.file_browser.actions").create,
              -- Remove <C-m> mapping to restore default enter behavior
            },
            ["n"] = {
              ["d"] = require("telescope._extensions.file_browser.actions").remove,
              ["r"] = require("telescope._extensions.file_browser.actions").rename,
              ["y"] = require("telescope._extensions.file_browser.actions").copy,
              ["n"] = require("telescope._extensions.file_browser.actions").create,
              -- Remove m mapping to restore default enter behavior
            },
          },
        },
      },
    })
    
    telescope.load_extension("file_browser")
  end,
}
