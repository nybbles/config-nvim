local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function get_filename()
  local filename = vim.fn.expand("%:t:r")
  return filename:gsub("-", "_"):gsub("(%l)(%w*)", function(a, b) return a:upper() .. b end)
end

return {
  -- Neovim plugin spec
  s("plug", fmt([[
    return {{
      "{repo}",
      {config}
    }}
  ]], {
    repo = i(1, "author/plugin-name"),
    config = c(2, {
      fmt("config = function()\n      {}\n    end,", {i(1, "-- configuration")}),
      fmt("opts = {{\n      {}\n    }},", {i(1, "-- options")}),
      fmt("lazy = {lazy},\n    event = \"{event}\",", {
        lazy = c(1, {t("true"), t("false")}),
        event = i(2, "VeryLazy")
      }),
      t("enabled = false,")
    })
  })),

  -- Autocommand
  s("autocmd", fmt([[
    vim.api.nvim_create_autocmd("{events}", {{
      group = vim.api.nvim_create_augroup("{group}", {{ clear = true }}),
      pattern = "{pattern}",
      callback = function({callback_args})
        {body}
      end,
    }})
  ]], {
    events = c(1, {
      t("BufWritePre"), t("BufReadPost"), t("BufEnter"), t("VimEnter"),
      t("FileType"), t("TextChanged"), t("InsertEnter"), t("InsertLeave")
    }),
    group = i(2, "MyGroup"),
    pattern = i(3, "*"),
    callback_args = c(4, {t(""), t("event")}),
    body = i(0, "-- callback code")
  })),

  -- Keymap
  s("keymap", fmt([[
    vim.keymap.set("{mode}", "{lhs}", {rhs}, {{ desc = "{desc}"{opts} }})
  ]], {
    mode = c(1, {t("n"), t("i"), t("v"), t("x"), t("t"), t("c")}),
    lhs = i(2, "<leader>x"),
    rhs = c(3, {
      fmt("function() {} end", {i(1, "-- function body")}),
      fmt("\"{command}\"", {i(1, ":command")}),
      fmt("require('{module}').{func}", {
        module = i(1, "module"),
        func = i(2, "function")
      })
    }),
    desc = i(4, "Description"),
    opts = c(5, {
      t(""),
      t(", buffer = true"),
      t(", silent = true"),
      t(", noremap = true")
    })
  })),

  -- User command
  s("usercmd", fmt([[
    vim.api.nvim_create_user_command("{name}", function({args})
      {body}
    end, {{
      desc = "{description}",
      {options}
    }})
  ]], {
    name = i(1, "MyCommand"),
    args = c(2, {t(""), t("opts")}),
    body = i(3, "print('Command executed')"),
    description = i(4, "My custom command"),
    options = c(5, {
      t("nargs = 0"),
      t("nargs = 1"),
      t("nargs = '*'"),
      t("range = true"),
      t("complete = 'file'")
    })
  })),

  -- Function
  s("function", fmt([[
    local function {name}({params})
      {body}
      return {return_value}
    end
  ]], {
    name = i(1, "my_function"),
    params = i(2),
    body = i(3, "-- function body"),
    return_value = i(0, "result")
  })),

  -- Module
  s("module", fmt([[
    local M = {{}}
    
    {private_functions}
    
    function M.{public_function}({params})
      {body}
      return {return_value}
    end
    
    return M
  ]], {
    private_functions = i(1, "-- Private functions"),
    public_function = i(2, "setup"),
    params = i(3, "opts"),
    body = i(4, "-- implementation"),
    return_value = i(0, "true")
  })),

  -- AstroNvim plugin config
  s("astro", fmt([[
    return {{
      "AstroNvim/astrocore",
      opts = {{
        {config_type} = {{
          {config_content}
        }},
      }},
    }}
  ]], {
    config_type = c(1, {t("options"), t("mappings"), t("autocmds")}),
    config_content = i(0, "-- configuration")
  })),

  -- Lazy plugin spec
  s("lazy", fmt([[
    {{
      "{repo}",
      lazy = {lazy},
      event = "{event}",
      dependencies = {{
        {dependencies}
      }},
      config = function()
        {config}
      end,
    }}
  ]], {
    repo = i(1, "author/plugin"),
    lazy = c(2, {t("true"), t("false")}),
    event = c(3, {t("VeryLazy"), t("BufReadPost"), t("InsertEnter"), t("UIEnter")}),
    dependencies = i(4, "\"dep/plugin\""),
    config = i(0, "require('plugin').setup({})")
  })),

  -- Telescope picker
  s("telescope", fmt([[
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    
    local function {picker_name}(opts)
      opts = opts or {{}}
      
      pickers.new(opts, {{
        prompt_title = "{title}",
        finder = finders.new_table {{
          results = {{ {results} }},
        }},
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            {selection_action}
          end)
          return true
        end,
      }}):find()
    end
    
    return {picker_name}
  ]], {
    picker_name = i(1, "my_picker"),
    title = i(2, "My Picker"),
    results = i(3, "\"item1\", \"item2\", \"item3\""),
    selection_action = i(0, "print(selection[1])")
  })),

  -- LuaSnip snippet definition
  s("snippet", fmt([[
    s("{trigger}", fmt([[
      {snippet_body}
    ]], {{
      {placeholders}
    }})),
  ]], {
    trigger = i(1, "trigger"),
    snippet_body = i(2, "Hello {name}!"),
    placeholders = i(0, "name = i(1, \"World\")")
  })),

  -- Highlight group
  s("highlight", fmt([[
    vim.api.nvim_set_hl(0, "{group}", {{
      {properties}
    }})
  ]], {
    group = i(1, "MyHighlight"),
    properties = i(0, "fg = \"#ffffff\", bg = \"#000000\", bold = true")
  })),

  -- Table with metatable
  s("metatable", fmt([[
    local {name} = {{}}
    {name}.__index = {name}
    
    function {name}.new({params})
      local self = setmetatable({{
        {fields}
      }}, {name})
      return self
    end
    
    function {name}:{method}({method_params})
      {method_body}
    end
    
    return {name}
  ]], {
    name = i(1, "MyClass"),
    params = i(2, "value"),
    fields = i(3, "value = value"),
    method = i(4, "method"),
    method_params = i(5),
    method_body = i(0, "-- method implementation")
  })),

  -- Protected call (pcall)
  s("pcall", fmt([[
    local ok, {result} = pcall({func}, {args})
    if not ok then
      {error_handling}
      return {error_return}
    end
    {success_handling}
  ]], {
    result = i(1, "result"),
    func = i(2, "function_name"),
    args = i(3, "arg1, arg2"),
    error_handling = i(4, "vim.notify(\"Error: \" .. result, vim.log.levels.ERROR)"),
    error_return = i(5, "nil"),
    success_handling = i(0, "return result")
  })),
}