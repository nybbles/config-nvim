return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("illuminate").configure({
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 100,
      filetype_overrides = {},
      filetypes_denylist = {
        "dirbuf",
        "dirvish",
        "fugitive",
        "neo-tree",
        "NvimTree",
        "TelescopePrompt",
        "alpha",
        "dashboard",
        "DoomInfo",
        "help",
        "lazy",
        "lazyterm",
        "mason",
        "notify",
        "Outline",
        "toggleterm",
        "trouble",
        "which-key",
        "aerial",
        "spectre_panel",
      },
      filetypes_allowlist = {},
      modes_denylist = {},
      modes_allowlist = {},
      providers_regex_syntax_denylist = {},
      providers_regex_syntax_allowlist = {},
      under_cursor = true,
      large_file_cutoff = nil,
      large_file_overrides = nil,
      min_count_to_highlight = 2,
      should_enable = function(bufnr)
        -- Disable for large files
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max_filesize then
          return false
        end
        return true
      end,
      case_insensitive_regex = false,
    })
  end,
  specs = {
    {
      "AstroNvim/astroui",
      opts = function(_, opts)
        local get_hlgroup = require("astroui").get_hlgroup
        local normal = get_hlgroup("Normal")
        local comment = get_hlgroup("Comment")
        
        opts.highlights.init = vim.tbl_deep_extend("force", opts.highlights.init or {}, {
          IlluminatedWordText = { bg = "#3e4451", underline = true },
          IlluminatedWordRead = { bg = "#3e4451", underline = true },
          IlluminatedWordWrite = { bg = "#4a5568", underline = true, bold = true },
        })
      end,
    },
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        -- Navigation mappings for illuminated references
        maps.n["<A-n>"] = {
          function() require("illuminate").goto_next_reference(false) end,
          desc = "Move to next reference",
        }
        maps.n["<A-p>"] = {
          function() require("illuminate").goto_prev_reference(false) end,
          desc = "Move to previous reference",
        }
        -- Toggle illuminate
        maps.n["<Leader>ui"] = {
          function()
            local illuminate = require("illuminate")
            local bufnr = vim.api.nvim_get_current_buf()
            if vim.b[bufnr].illuminate_enabled == false then
              illuminate.resume_buf()
              vim.notify("Illuminate enabled", vim.log.levels.INFO)
            else
              illuminate.pause_buf()
              vim.notify("Illuminate disabled", vim.log.levels.INFO)
            end
          end,
          desc = "Toggle illuminate",
        }
      end,
    },
  },
}