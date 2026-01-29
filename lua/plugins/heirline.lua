return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")

    local bookmarks_component = status.component.builder({
      {
        provider = function()
          local ok, bookmarks = pcall(require, "bookmarks")
          if not ok then return "" end

          local status_ok, result = pcall(bookmarks.status_short)
          if not status_ok or type(result) ~= "string" then return "" end

          return result
        end,
      },
      surround = { separator = "right" },
    })

    if opts.statusline then
      table.insert(opts.statusline, #opts.statusline, bookmarks_component)
    end

    return opts
  end,
}
