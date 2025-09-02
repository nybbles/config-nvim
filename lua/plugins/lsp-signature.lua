return {
  "ray-x/lsp_signature.nvim",
  enabled = false,
  event = "VeryLazy",
  opts = {
    bind = true,
    doc_lines = 10,
    max_height = 30,
    max_width = 120,
    wrap = true,
    floating_window = true,
    floating_window_above_cur_line = true,
    fix_pos = true,
    hint_enable = true,
    hint_prefix = "🔍 ",
    hint_scheme = "String",
    hi_parameter = "Search",
    handler_opts = {
      border = "rounded"
    },
    always_trigger = true,
    auto_close_after = nil,
    extra_trigger_chars = {",", "("},
    zindex = 200,
    padding = '',
    transparency = nil,
    shadow_guibg = 'Black',
    shadow_blend = 36,
    timer_interval = 200,
    toggle_key = '<C-k>',        -- Press this key to show/hide signature
    select_signature_key = '<C-n>', -- cycle to next signature
    move_cursor_key = nil,
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}