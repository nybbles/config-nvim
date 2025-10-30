
-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  { "AstroNvim/astrocommunity" },
  { import = "astrocommunity.pack.terraform" },
  
  -- Disabled for performance - can be re-enabled as needed:
  -- { import = "astrocommunity.pack.markdown" },
  -- { import = "astrocommunity.split-and-window.windows-nvim" },
  -- { import = "astrocommunity.editing-support.zen-mode-nvim" },
  -- { import = "astrocommunity.editing-support.vim-move" },
  -- { import = "astrocommunity.recipes.neovide" },
}
