-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  { "AstroNvim/astrocommunity" },
  -- Language packs with enhanced snippets
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.terraform" },
  { import = "astrocommunity.pack.helm" },
  
  -- Enhanced editing support
  { import = "astrocommunity.editing-support.nvim-devdocs" },
  
  -- Disabled for performance - can be re-enabled as needed:
  -- { import = "astrocommunity.pack.markdown" },
  -- { import = "astrocommunity.split-and-window.windows-nvim" },
  -- { import = "astrocommunity.editing-support.zen-mode-nvim" },
  -- { import = "astrocommunity.editing-support.vim-move" },
  -- { import = "astrocommunity.recipes.neovide" },
}
