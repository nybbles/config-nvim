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
            -- Disable the default <leader>n mapping that creates a new file
            ["<Leader>n"] = false,
            
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
            ["<Leader>ts"] = {
              function() require("custom.terminal-picker").terminal_picker() end,
              desc = "Search/select terminal",
            },
            ["<Leader>tf"] = {
              function() require("custom.terminal-picker").terminal_picker { direction = "float" } end,
              desc = "Float terminal",
            },
            ["<Leader>th"] = {
              function() require("custom.terminal-picker").terminal_picker { direction = "horizontal" } end,
              desc = "Horizontal terminal",
            },
            ["<Leader>tv"] = {
              function() require("custom.terminal-picker").terminal_picker { direction = "vertical" } end,
              desc = "Vertical terminal",
            },
            ["<Leader>tr"] = { "<cmd>ToggleTermSetName<cr>", desc = "Rename terminal" },
            ["<Leader>tg"] = {
              function() require("custom.terminal-picker").terminal_picker { cmd = "lazygit", direction = "float" } end,
              desc = "Lazygit terminal",
            },

            ["<Leader>ln"] = { "<cmd>Navbuddy<cr>", desc = "Navbuddy" },
            ["<Leader>lw"] = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search workspace symbols" },
            
            -- LSP References and Refactoring
            ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "References" },
            ["gd"] = { "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition" },
            ["gi"] = { "<cmd>Telescope lsp_implementations<cr>", desc = "Go to implementation" },
            ["gt"] = { "<cmd>Telescope lsp_type_definitions<cr>", desc = "Go to type definition" },
            ["<Leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename symbol" },
            ["<Leader>lc"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code actions" },

            -- File operations
            ["<Leader>f"] = { name = "Find" },
            ["<Leader>fb"] = { 
              function()
                local path = nil
                
                -- Check if we're in neo-tree
                if vim.bo.filetype == "neo-tree" then
                  -- Get the current node in neo-tree
                  local neo_tree_utils = require("neo-tree.utils")
                  local manager = require("neo-tree.sources.manager")
                  local state = manager.get_state("filesystem")
                  local node = state.tree:get_node()
                  
                  if node then
                    path = node.path
                    -- If it's a file, use its directory; if it's a directory, use it directly
                    if node.type == "file" then
                      path = vim.fn.fnamemodify(path, ":h")
                    end
                  end
                else
                  -- Check if current buffer has a file
                  local current_file = vim.api.nvim_buf_get_name(0)
                  if current_file and current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
                    -- Use the directory of the current file
                    path = vim.fn.fnamemodify(current_file, ":h")
                  end
                end
                
                -- Open telescope file browser with determined path or fallback to cwd
                if path then
                  require("telescope").extensions.file_browser.file_browser({ path = path })
                else
                  require("telescope").extensions.file_browser.file_browser()
                end
              end,
              desc = "File browser (context-aware)" 
            },

            gL = { "<cmd>GithubLink<cr>", desc = "Copy Github link to clipboard" },

            ["<Leader>O"] = { "<cmd>Octo<cr>", desc = "Octo" },

            ["<Leader>x"] = { name = "Trouble" },
            ["<Leader>xx"] = { "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
            ["<Leader>xX"] = {
              "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
              desc = "Buffer diagnostics",
            },
            ["<Leader>xs"] = { "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
            ["<Leader>xl"] = {
              "<cmd>Trouble lsp toggle focus=false<cr>",
              desc = "LSP references, definitions, ...",
            },
            ["<Leader>xL"] = { "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
            ["<Leader>xQ"] = { "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
          },
          v = {
            -- Visual mode LSP mappings
            ["<Leader>l"] = { name = "LSP" },
            ["<Leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code action" },
            ["<Leader>lf"] = { "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format selection" },
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
