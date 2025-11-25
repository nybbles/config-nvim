return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "S",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
      surrounds = {
        -- Custom Rust surrounds
        ["r"] = {
          add = function()
            local result = require("nvim-surround.config").get_input("Enter the Rust raw string delimiter: ")
            if result then
              return { { "r#\"" .. result }, { result .. "\"#" } }
            end
          end,
          find = "r#+\".-\"+",
          delete = "^(r#+\")().-(\"#+)()$",
        },
        ["m"] = {
          add = { "/* ", " */" },
          find = "/%*.-/%*/",
          delete = "^(%/%* ?)().-( ?%*%/)()$",
        },
        ["c"] = {
          add = { "// ", "" },
          find = "//.-\n",
          delete = "^(// ?)().-()()$",
        },
        -- Function call surround
        ["f"] = {
          add = function()
            local result = require("nvim-surround.config").get_input("Enter the function name: ")
            if result then
              return { { result .. "(" }, { ")" } }
            end
          end,
          find = function()
            return require("nvim-surround.config").get_selection({ motion = "af" })
          end,
          delete = "^(.-%()().-(%))()$",
          change = {
            target = "^(.-%()().-(%))()$",
            replacement = function()
              local result = require("nvim-surround.config").get_input("Enter the function name: ")
              if result then
                return { { result .. "(" }, { ")" } }
              end
            end,
          },
        },
        -- Macro surround for Rust
        ["M"] = {
          add = function()
            local result = require("nvim-surround.config").get_input("Enter the macro name: ")
            if result then
              return { { result .. "!(" }, { ")" } }
            end
          end,
          find = function()
            return require("nvim-surround.config").get_selection({ motion = "af" })
          end,
          delete = "^(.-%!%()().-(%))()$",
        },
        -- Generic type parameters
        ["<"] = { add = { "<", ">" }, find = "<.->", delete = "^(<)().-(>)()$" },
        -- Array/Vec literal
        ["V"] = { add = { "vec![", "]" }, find = "vec!%[.-%]", delete = "^(vec!%[)().-(])()$" },
        -- Box::new()
        ["B"] = { add = { "Box::new(", ")" }, find = "Box::new%(.-%))", delete = "^(Box::new%()().-(%))()$" },
        -- Rc::new()
        ["R"] = { add = { "Rc::new(", ")" }, find = "Rc::new%(.-%))", delete = "^(Rc::new%()().-(%))()$" },
        -- Arc::new()
        ["A"] = { add = { "Arc::new(", ")" }, find = "Arc::new%(.-%))", delete = "^(Arc::new%()().-(%))()$" },
      },
      aliases = {
        ["a"] = ">", -- angle brackets
        ["p"] = ")", -- parentheses
        ["s"] = "]", -- square brackets
        ["c"] = "}", -- curly braces
        ["q"] = { '"', "'", "`" }, -- quotes
      },
      highlight = {
        duration = 200,
      },
      move_cursor = "begin",
      indent_lines = function(start, stop)
        local b = vim.bo
        return start < stop and (b.filetype == "rust" or b.filetype == "lua" or b.filetype == "python")
      end,
    })
  end,
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        -- Additional surround-related mappings
        maps.n["<Leader>y"] = { desc = " Surround" }
        maps.x["<Leader>y"] = { desc = " Surround" }
        maps.n["<Leader>ys"] = { "ys", desc = "Add surround" }
        maps.n["<Leader>yss"] = { "yss", desc = "Add surround to line" }
        maps.n["<Leader>yd"] = { "ds", desc = "Delete surround" }
        maps.n["<Leader>yc"] = { "cs", desc = "Change surround" }
        maps.x["<Leader>ys"] = { "S", desc = "Add surround to selection" }
      end,
    },
  },
}