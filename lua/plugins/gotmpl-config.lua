-- Configuration for Go template (gotmpl) syntax highlighting
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Ensure gotmpl highlighting is properly configured
    opts.highlight = opts.highlight or {}
    opts.highlight.enable = true
    
    -- Add specific configuration for gotmpl
    if not opts.highlight.additional_vim_regex_highlighting then
      opts.highlight.additional_vim_regex_highlighting = {}
    end
    
    -- Enable additional regex highlighting for gotmpl to catch edge cases
    if type(opts.highlight.additional_vim_regex_highlighting) == "table" then
      table.insert(opts.highlight.additional_vim_regex_highlighting, "gotmpl")
    end
    
    return opts
  end,
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    
    -- Force gotmpl parser installation and highlighting
    vim.defer_fn(function()
      local parsers = require("nvim-treesitter.parsers")
      if parsers.has_parser("gotmpl") then
        vim.cmd([[
          augroup GotmplHighlight
            autocmd!
            autocmd FileType gotmpl TSBufEnable highlight
            autocmd FileType gotmpl setlocal syntax=gotmpl
          augroup END
        ]])
      end
    end, 100)
  end,
}