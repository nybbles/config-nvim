local M = {}

function M.terminal_picker(opts)
  opts = opts or {}
  local direction = opts.direction or "float"
  local cmd = opts.cmd
  
  local toggleterm = require("toggleterm")
  local terminal = require("toggleterm.terminal")
  local telescope = require("telescope")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  local themes = require("telescope.themes")

  local terminals = terminal.get_all()
  local items = {}

  -- Build list of existing terminals
  for _, term in ipairs(terminals) do
    local name = term.display_name or ("Terminal " .. term.id)
    local status = term:is_open() and "[open]" or "[closed]"
    local dir_info = term.direction and (" [" .. term.direction .. "]") or ""
    table.insert(items, {
      name = name,
      id = term.id,
      display = string.format("%s %s%s - %s", term.id, name, dir_info, status),
      terminal = term,
      is_existing = true
    })
  end

  -- Create the picker
  local picker_opts = themes.get_dropdown({
    prompt_title = "Select or Create Terminal (" .. direction .. ")",
    previewer = false,
    layout_config = {
      width = 0.6,
      height = 0.4,
    },
  })

  pickers.new(picker_opts, {
    finder = finders.new_table({
      results = items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display,
          ordinal = entry.name .. " " .. entry.id,
        }
      end,
    }),
    sorter = conf.generic_sorter(picker_opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        if selection then
          -- Open existing terminal with new direction
          local term = selection.value.terminal
          term.direction = direction
          term:toggle()
        else
          -- Get the prompt text as the new terminal name
          local prompt_text = action_state.get_current_line()
          if prompt_text and prompt_text ~= "" then
            -- Create new terminal with the given name
            local new_term = terminal.Terminal:new({
              display_name = prompt_text,
              direction = direction,
              cmd = cmd,
              on_open = function(term)
                vim.defer_fn(function()
                  vim.cmd("startinsert!")
                end, 100)
              end,
            })
            new_term:toggle()
          end
        end
      end)

      -- Add action to create new terminal with prompt text as name
      map("i", "<C-n>", function()
        local prompt_text = action_state.get_current_line()
        actions.close(prompt_bufnr)
        
        if prompt_text and prompt_text ~= "" then
          local new_term = terminal.Terminal:new({
            display_name = prompt_text,
            direction = "float",
            on_open = function(term)
              vim.defer_fn(function()
                vim.cmd("startinsert!")
              end, 100)
            end,
          })
          new_term:toggle()
        end
      end)

      -- Add action to delete terminal
      map("i", "<C-d>", function()
        local selection = action_state.get_selected_entry()
        if selection and selection.value.is_existing then
          selection.value.terminal:shutdown()
          actions.close(prompt_bufnr)
          -- Reopen the picker
          vim.defer_fn(function()
            M.terminal_picker()
          end, 100)
        end
      end)

      return true
    end,
  }):find()
end

return M