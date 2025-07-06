" Instinct Light theme for Neovim
" Inspired by Garmin Instinct 2X Solar - tactical, high-contrast design for daylight

set background=light

" Define custom colors for light theme
let s:white = "#f8f8f8"
let s:black = "#1a1a1a"
let s:dark_black = "#000000"
let s:gray = "#e8e8e8"
let s:dim_gray = "#555555"
let s:orange = "#d35400"
let s:blue = "#2980b9"
let s:green = "#27ae60"
let s:yellow = "#f39c12"
let s:red = "#c0392b"
let s:cyan = "#16a085"
let s:purple = "#8e44ad"

" Clear existing highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "instinct-light"

" Editor settings
exec "hi Normal guifg=" . s:black . " guibg=" . s:white
exec "hi Cursor guifg=" . s:white . " guibg=" . s:orange
exec "hi CursorLine guibg=" . s:gray
exec "hi LineNr guifg=" . s:dim_gray . " guibg=" . s:white
exec "hi CursorLineNr guifg=" . s:orange . " guibg=" . s:gray

" Syntax highlighting
exec "hi Comment guifg=" . s:dim_gray
exec "hi Constant guifg=" . s:yellow
exec "hi String guifg=" . s:green
exec "hi Character guifg=" . s:green
exec "hi Number guifg=" . s:yellow
exec "hi Boolean guifg=" . s:yellow
exec "hi Float guifg=" . s:yellow

exec "hi Identifier guifg=" . s:black
exec "hi Function guifg=" . s:blue

exec "hi Statement guifg=" . s:orange
exec "hi Conditional guifg=" . s:orange
exec "hi Repeat guifg=" . s:orange
exec "hi Label guifg=" . s:orange
exec "hi Operator guifg=" . s:black
exec "hi Keyword guifg=" . s:orange
exec "hi Exception guifg=" . s:red

exec "hi PreProc guifg=" . s:purple
exec "hi Include guifg=" . s:purple
exec "hi Define guifg=" . s:purple
exec "hi Macro guifg=" . s:purple
exec "hi PreCondit guifg=" . s:purple

exec "hi Type guifg=" . s:cyan
exec "hi StorageClass guifg=" . s:cyan
exec "hi Structure guifg=" . s:cyan
exec "hi Typedef guifg=" . s:cyan

exec "hi Special guifg=" . s:orange
exec "hi SpecialChar guifg=" . s:orange
exec "hi Tag guifg=" . s:orange
exec "hi Delimiter guifg=" . s:black
exec "hi SpecialComment guifg=" . s:orange
exec "hi Debug guifg=" . s:red

" UI elements
exec "hi Visual guibg=" . s:gray
exec "hi Search guifg=" . s:white . " guibg=" . s:yellow
exec "hi IncSearch guifg=" . s:white . " guibg=" . s:orange
exec "hi StatusLine guifg=" . s:black . " guibg=" . s:gray
exec "hi StatusLineNC guifg=" . s:dim_gray . " guibg=" . s:gray
exec "hi VertSplit guifg=" . s:gray . " guibg=" . s:white
exec "hi Pmenu guifg=" . s:black . " guibg=" . s:gray
exec "hi PmenuSel guifg=" . s:white . " guibg=" . s:orange