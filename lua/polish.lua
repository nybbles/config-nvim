-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Configure autoread for automatically updating buffers when modified externally
vim.opt.autoread = true

-- Disable inccommand to prevent UI issues during search
vim.opt.inccommand = ""

-- Ensure Catppuccin is the default colorscheme
-- vim.cmd.colorscheme("catppuccin")

require("themester").setup()

-- Setup autocmds for code outline plugins to reduce gutter width
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "Outline" },
  callback = function()
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.numberwidth = 1
  end,
})

-- Create autocmd to check for file changes and reload automatically
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  callback = function()
    if vim.fn.getcmdwintype() == "" then vim.cmd "checktime" end
  end,
  desc = "Check for external file changes",
})

-- Optionally notify on file change
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function() vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO) end,
  desc = "Notify when file is changed externally",
})

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
