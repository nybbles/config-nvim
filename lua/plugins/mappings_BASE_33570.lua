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

            ["<Leader>w"] = { name = "Windows" },
            ["<Leader>wz"] = { "<cmd>WindowsMaximize<cr>", desc = "Maximize windows" },
            ["<Leader>w_"] = { "<cmd>WindowsMaximizeVertically<cr>", desc = "Maximize windows vertically" },
            ["<Leader>w|"] = { "<cmd>WindowsMaximizeHorizontally<cr>", desc = "Maximize windows horizonally" },
            ["<Leader>w="] = { "<cmd>WindowsEqualize<cr>", desc = "Equalize windows" },

            ["<Leader>t"] = { name = "Terminals" },
            ["<Leader>ts"] = { "<cmd>TermSelect<cr>", desc = "Select terminal" },
            ["<Leader>tr"] = { "<cmd>ToggleTermSetName<cr>", desc = "Rename terminal" },

            ["<Leader>ln"] = { "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
            ["<Leader>lw"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search workspace symbols" },

            gL = { "<cmd>GithubLink<cr>", desc = "Copy Github link to clipboard" },

            ["<Leader>O"] = { "<cmd>Octo<cr>", desc = "Octo" },

            ["<Leader>x"] = { name = "Trouble" },
            ["<Leader>xx"] = { "<cmd>Trouble diagnostics toggle win.position=right<cr>", desc = "Diagnostics" },
            ["<Leader>xX"] = {
              "<cmd>Trouble diagnostics toggle filter.buf=0 win.position=right<cr>",
              desc = "Buffer diagnostics",
            },
            ["<Leader>xs"] = { "<cmd>Trouble symbols toggle focus=false win.position=right<cr>", desc = "Symbols" },
            ["<Leader>xl"] = {
              "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
              desc = "LSP references, definitions, ...",
            },
            ["<Leader>xL"] = { "<cmd>Trouble loclist toggle win.position=right<cr>", desc = "Location list" },
            ["<Leader>xQ"] = { "<cmd>Trouble qflist toggle win.position=right<cr>", desc = "Quickfix list" },
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
