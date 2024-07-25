return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "folke/trouble.nvim",
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
  end,
}
