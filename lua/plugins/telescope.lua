return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "-u",
      },
      file_ignore_patterns = {
        ".git",
        "node_modules",
        ".venv",
      },
    },
  },
}
