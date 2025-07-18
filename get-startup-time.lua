-- Simple script to get Neovim startup time using lazy.nvim stats
-- Wait for lazy to fully load
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    vim.schedule(function()
      local stats = require("lazy").stats()
      local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
      print(string.format("Startup time: %.2fms", ms))
      print(string.format("Loaded plugins: %d/%d", stats.loaded, stats.count))
      vim.cmd("quit")
    end)
  end,
})