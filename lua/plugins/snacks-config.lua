return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = vim.tbl_deep_extend("force", opts.picker or {}, {
      ui_select = true,
    })
    
    return opts
  end,
}