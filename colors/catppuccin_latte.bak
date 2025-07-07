" Catppuccin Latte theme for Neovim
" This file sets up the colorscheme to use catppuccin-latte
" Requires catppuccin/nvim plugin to be installed

" Set background to light
set background=light

" Configure catppuccin before loading
let g:catppuccin_flavour = "latte"

" Load catppuccin colorscheme
try
    colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
    " catppuccin not installed, fallback to a similar light theme
    try
        colorscheme morning
    catch /^Vim\%((\a\+)\)\=:E185/
        " Use default if nothing works
        colorscheme default
    endtry
endtry