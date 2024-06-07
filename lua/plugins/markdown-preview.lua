return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  file = { "markdown" },
  build = function() vim.fn["mkdp#util#install"]() end,
}
