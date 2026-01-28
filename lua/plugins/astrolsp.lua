-- AstroLSP configuration is now active

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
          "markdown", -- explicitly enable for markdown
          "nix", -- enable format on save for Nix files
          "terraform", -- enable format on save for Terraform files
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
        "marksman", -- ensure marksman doesn't format
      },
      timeout_ms = 3000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      marksman = {
        settings = {
          marksman = {
            completion = {
              wiki = {
                style = "title"
              }
            }
          }
        },
        on_attach = function(client, bufnr)
          -- Disable Marksman's formatting capability to use prettierd instead
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
      ruff_lsp = {
        init_options = {
          settings = {
            args = {
              "--select=ALL",
              "--ignore=E501,W505,D100,D101,D102,D103,D104,D105,D107",
            },
          },
        },
        on_attach = function(client, bufnr)
          if client.name == "ruff_lsp" then
            -- Disable hover in favor of pylsp
            client.server_capabilities.hoverProvider = false
            -- Enable code actions and formatting
            client.server_capabilities.codeActionProvider = true
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
          end

          local navbuddy = require "nvim-navbuddy"
          navbuddy.attach(client, bufnr)
        end,
      },
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              jedi_completion = {
                enabled = true,
                fuzzy = true,
                eager = true,
                include_class_objects = true,
                include_params = true,
                include_function_objects = true,
              },
              jedi_hover = { enabled = true },
              jedi_references = { enabled = true },
              jedi_definition = { enabled = true },
              jedi_symbols = { enabled = true },
              jedi_signature_help = { enabled = true },
              rope_autoimport = {
                enabled = true,
              },
              rope_completion = {
                enabled = true,
              },
              rope_rename = {
                enabled = true,
              },
              -- Enhanced code actions
              rope_refactor = {
                enabled = true,
              },
              pycodestyle = {
                enabled = false,
              },
              mccabe = {
                enabled = false,
              },
              pyflakes = {
                enabled = false,
              },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              ruff = {
                enabled = true,
                formatEnabled = true,
                targetVersion = "py311",
              },
            },
          },
        },
      },
      -- Enhanced file format support
      yamlls = {
        settings = {
          yaml = {
            validate = true,
            hover = true,
            completion = true,
            format = {
              enable = true,
            },
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://json.schemastore.org/github-action.json"] = "/action.{yml,yaml}",
              ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.{yml,yaml}",
              ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
              ["https://json.schemastore.org/chart.json"] = "Chart.{yml,yaml}",
            },
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            validate = { enable = true },
            format = { enable = true },
            -- Use conditional schemastore loading for AstroNvim compatibility
            schemas = (function()
              local ok, schemastore = pcall(require, 'schemastore')
              local base_schemas = {}
              
              if ok then
                base_schemas = schemastore.json.schemas()
              else
                -- Fallback to basic schemas if schemastore not available
                base_schemas = {
                  {
                    fileMatch = { "package.json" },
                    url = "https://json.schemastore.org/package.json"
                  },
                  {
                    fileMatch = { "tsconfig*.json" },
                    url = "https://json.schemastore.org/tsconfig.json"
                  },
                }
              end
              
              -- Add OpenAPI schema support
              vim.list_extend(base_schemas, {
                {
                  fileMatch = { "*openapi*.json", "*swagger*.json", "api-spec.json" },
                  url = "https://spec.openapis.org/oas/v3.1/schema/2022-10-07"
                },
                {
                  fileMatch = { "openapi.json" },
                  url = "https://spec.openapis.org/oas/v3.1/schema/2022-10-07"
                }
              })
              
              return base_schemas
            end)(),
          },
        },
        on_attach = function(client, bufnr)
          -- Attach navbuddy to jsonls for better navigation
          local has_navbuddy, navbuddy = pcall(require, "nvim-navbuddy")
          if has_navbuddy then
            navbuddy.attach(client, bufnr)
          end
        end,
      },
      taplo = {
        -- Enhanced TOML support (especially for Cargo.toml)
        settings = {
          taplo = {
            configFile = {
              enabled = true,
            },
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      rust_analyzer = false, -- setting a handler to false will disable the set up of that language server (using rustaceanvim instead)
      pyright = false, -- explicitly disable pyright in favor of basedpyright
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      -- lsp_document_highlight = {
      --   -- Optional condition to create/delete auto command group
      --   -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
      --   -- condition will be resolved for each client on each execution and if it ever fails for all clients,
      --   -- the auto commands will be deleted for that buffer
      --   cond = "textDocument/documentHighlight",
      --   -- cond = function(client, bufnr) return client.name == "lua_ls" end,
      --   -- list of auto commands to set
      --   {
      --     -- events to trigger
      --     event = { "CursorHold", "CursorHoldI" },
      --     -- the rest of the autocmd options (:h nvim_create_autocmd)
      --     desc = "Document Highlighting",
      --     callback = function() vim.lsp.buf.document_highlight() end,
      --   },
      --   {
      --     event = { "CursorMoved", "CursorMovedI", "BufLeave" },
      --     desc = "Document Highlighting Clear",
      --     callback = function() vim.lsp.buf.clear_references() end,
      --   },
      -- },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
        ["<Leader>lG"] = false,
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}
