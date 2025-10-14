return {
  {
    "otavioschwanck/arrow.nvim",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { ";", function() require("arrow.persist").toggle() end, desc = "Arrow bookmarks" },
    },
    opts = {
      show_icons = true,
      always_show_path = false,
      separate_by_branch = true,
      hide_handbook = false,
      save_path = function()
        return vim.fn.stdpath("cache") .. "/arrow"
      end,
      mappings = {
        edit = "e",
        delete_mode = "d",
        clear_all_items = "C",
        toggle = "s",
        open_vertical = "v",
        open_horizontal = "-",
        quit = "q",
        remove = "x",
        next_item = "]",
        prev_item = "[",
      },
      window = {
        width = "auto",
        height = "auto",
        row = "auto",
        col = "auto",
        border = "double",
      },
      per_buffer_config = {
        lines = 4,
        sort_automatically = true,
      },
      leader_key = ";",
      buffer_leader_key = "m",
      global_bookmarks = false,
      index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP",
      full_path_list = { "update_stuff" },
    },
    config = function(_, opts)
      require("arrow").setup(opts)
    end,
  },
}