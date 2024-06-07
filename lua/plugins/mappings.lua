return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = function(_, default_opts)
      default_opts.mappings.n["<Leader>w"] = nil
      default_opts.mappings.n["<Leader>lG"] = false

      local opts = {
        mappings = {
          -- first key is the mode
          n = {
            -- second key is the lefthand side of the map
            -- mappings seen under group name "Buffer"
            ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
            ["<Leader>bD"] = {
              function()
                require("astroui.status").heirline.buffer_picker(
                  function(bufnr) require("astrocore.buffer").close(bufnr) end
                )
              end,
              desc = "Pick to close",
            },
            -- tables with the `name` key will be registered with which-key if it's installed
            -- this is useful for naming menus
            ["<Leader>b"] = { name = "Buffers" },
            -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
            -- quick save

            ["<Leader>w"] = {
              name = "Windows",
              z = { "<cmd>WindowsMaximize<cr>", "Maximize windows" },
              _ = { "<cmd>WindowsMaximizeVertically<cr>", "Maximize windows vertically" },
              ["|"] = { "<cmd>WindowsMaximizeHorizontally<cr>", "Maximize windows horizonally" },
              ["="] = { "<cmd>WindowsEqualize<cr>", "Equalize windows" },
            },

            ["<Leader>t"] = {
              name = "Terminals",
              s = { "<cmd>TermSelect<cr>", "Select terminal" },
              r = { "<cmd>ToggleTermSetName<cr>", "Rename terminal" },
            },

            ["<Leader>ln"] = { "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
            ["<Leader>lw"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search workspace symbols" },

            ["g"] = {
              L = { "<cmd>GithubLink<cr>", "Copy Github link to clipboard" },
            },

            ["<Leader>O"] = { "<cmd>Octo<cr>", desc = "Octo" },
          },
          t = {
            -- setting a mapping to false will disable it
            -- ["<esc>"] = false,
          },
        },
      }
      return vim.tbl_deep_extend("keep", opts, default_opts)
    end,
  },

  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
