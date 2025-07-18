-- Script to compile Catppuccin theme for better performance
require("catppuccin").compile()
print("Catppuccin theme compiled successfully!")
print("Compiled theme saved to: " .. vim.fn.stdpath("cache") .. "/catppuccin")
vim.cmd("quit")