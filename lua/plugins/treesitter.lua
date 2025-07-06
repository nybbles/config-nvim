return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add languages needed for various plugins
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "javascript",
      "rust",
      "vim",
      "markdown",
      "markdown_inline",
      "python",
      "julia",
      "r",
      "yaml",
      "lua",
    })
  end,
}
