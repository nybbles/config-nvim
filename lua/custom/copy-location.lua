local M = {}

function M.copy_file_location()
  local file_path = vim.fn.expand("%")
  if file_path == "" then
    vim.notify("No file in current buffer", vim.log.levels.WARN)
    return
  end

  -- Get relative path from git root if in a git repo
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
  if vim.v.shell_error == 0 and git_root ~= "" then
    file_path = vim.fn.fnamemodify(file_path, ":p")
    if file_path:find(git_root, 1, true) == 1 then
      file_path = file_path:sub(#git_root + 2) -- +2 to remove the trailing slash
    end
  else
    -- Fall back to relative path from cwd
    file_path = vim.fn.fnamemodify(file_path, ":~:.")
  end

  local line_num = vim.fn.line(".")
  local location = file_path .. ":" .. line_num

  -- Copy to system clipboard
  vim.fn.setreg("+", location)
  vim.notify("Copied to clipboard: " .. location, vim.log.levels.INFO)
end

return M