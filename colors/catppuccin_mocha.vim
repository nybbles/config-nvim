" Catppuccin Mocha theme for Neovim
" This file sets up the colorscheme to use catppuccin-mocha
" Requires catppuccin/nvim plugin to be installed

" Set background to dark
set background=dark

" Configure catppuccin before loading
let g:catppuccin_flavour = "mocha"

" Load catppuccin colorscheme
try
    colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
    " catppuccin not installed, fallback to a similar dark theme
    try
        colorscheme desert
    catch /^Vim\%((\a\+)\)\=:E185/
        " Use default if nothing works
        colorscheme default
    endtry
endtry