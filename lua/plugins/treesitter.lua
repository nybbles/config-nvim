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
    
    -- Add error handling to prevent TreeSitter crashes
    opts.highlight = opts.highlight or {}
    opts.highlight.enable = true
    opts.highlight.disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
      return false
    end
    
    -- Additional safety measures
    opts.highlight.additional_vim_regex_highlighting = false
  end,
}
