-- Custom configuration for Obsidian note creation in slip-box directory structure

local M = {}

-- Helper function to create a note in slip-box with date-based structure
function M.create_note_in_slip_box(title)
  local obsidian = require("obsidian")
  local client = obsidian.get_client()
  
  -- Generate timestamp-based ID
  local timestamp = os.date("%Y%m%d-%H%M%S-%Z")
  local suffix = ""
  if title and title ~= "" then
    suffix = "-" .. title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
  end
  local note_id = timestamp .. suffix
  
  -- Create date-based path
  local year = os.date("%Y")
  local month = os.date("%m")
  local day = os.date("%d")
  
  -- Get the vault root and construct the full path
  local vault_root = client.dir.filename
  local slip_box_path = vault_root .. "/slip-box/" .. year .. "/" .. month .. "/" .. day
  
  -- Create the directory structure if it doesn't exist
  vim.fn.mkdir(slip_box_path, "p")
  
  -- Create the note file path
  local note_path = slip_box_path .. "/" .. note_id .. ".md"
  
  -- Create frontmatter content
  local human_title = title or "quick"
  human_title = human_title:gsub("^%l", string.upper):gsub("%-", " ")
  
  local content = {
    "---",
    "id: " .. note_id,
    "aliases:",
    "  - " .. human_title,
    "tags: []",
    "---",
    "",
    "# " .. human_title,
    ""
  }
  
  -- Write the file
  vim.fn.writefile(content, note_path)
  
  -- Open the file
  vim.cmd("edit " .. note_path)
  
  -- Move cursor to the end of the file
  vim.cmd("normal! G")
  
  print("Created note: " .. note_path)
end

-- Command for quick capture note
function M.quick_note()
  M.create_note_in_slip_box("quick")
end

-- Command for new note with title
function M.new_note(title)
  M.create_note_in_slip_box(title)
end

return M