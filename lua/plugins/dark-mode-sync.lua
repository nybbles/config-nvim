-- Auto-sync Neovim colorscheme with GNOME dark mode
return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    -- Function to detect GNOME dark mode
    local function is_dark_mode()
      local handle = io.popen("gsettings get org.gnome.desktop.interface gtk-theme 2>/dev/null")
      if handle then
        local result = handle:read("*a")
        handle:close()
        return result:match("dark") ~= nil
      end
      return true -- Default to dark mode
    end

    -- Function to set colorscheme based on system theme
    local function sync_colorscheme()
      if is_dark_mode() then
        require("catppuccin").setup({ flavour = "mocha" })
        vim.cmd.colorscheme("catppuccin-mocha")
      else
        require("catppuccin").setup({ flavour = "latte" })
        vim.cmd.colorscheme("catppuccin-latte")
      end
    end

    -- Initial setup
    require("catppuccin").setup({
      flavour = is_dark_mode() and "mocha" or "latte",
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = false,
      },
    })

    -- Set initial colorscheme
    sync_colorscheme()

    -- Watch for changes (check every 3 seconds)
    local timer = vim.loop.new_timer()
    if timer then
      timer:start(3000, 3000, vim.schedule_wrap(sync_colorscheme))
    end
  end,
}