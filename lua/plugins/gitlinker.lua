return {
  "ruifm/gitlinker.nvim",
  event = "BufEnter",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    require("gitlinker").setup({
      opts = {
        add_current_line_on_normal_mode = true,
        action_callback = function(url)
          vim.fn.setreg('+', url)
          vim.notify('Copied to clipboard: ' .. url)
        end,
        print_url = true,
      },
      callbacks = {
        ["github.com"] = require("gitlinker.hosts").get_github_type_url,
        ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
        ["bitbucket.org"] = require("gitlinker.hosts").get_bitbucket_type_url,
      },
    })
  end,
  keys = {
    { "<leader>gy", "<cmd>lua require'gitlinker'.get_buf_range_url('n')<cr>", desc = "Copy git link" },
    { "<leader>gy", "<cmd>lua require'gitlinker'.get_buf_range_url('v')<cr>", mode = "v", desc = "Copy git link" },
  },
}