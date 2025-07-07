" Instinct Dark theme for Neovim
" Inspired by Garmin Instinct 2X Solar - tactical, high-contrast design

set background=dark

" Define custom colors
let s:black = "#0a0a0a"
let s:white = "#f5f5f5"
let s:bright_white = "#ffffff"
let s:gray = "#2a2a2a"
let s:dim_gray = "#8a8a8a"
let s:orange = "#ff6b35"
let s:blue = "#4a90e2"
let s:green = "#32cd32"
let s:yellow = "#ffd700"
let s:red = "#e74c3c"
let s:cyan = "#17a2b8"
let s:purple = "#9b59b6"

" Clear existing highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "instinct-dark"

" Editor settings
exec "hi Normal guifg=" . s:white . " guibg=" . s:black
exec "hi Cursor guifg=" . s:black . " guibg=" . s:orange
exec "hi CursorLine guibg=" . s:gray
exec "hi LineNr guifg=" . s:dim_gray . " guibg=" . s:black
exec "hi CursorLineNr guifg=" . s:orange . " guibg=" . s:gray

" Syntax highlighting
exec "hi Comment guifg=" . s:dim_gray
exec "hi Constant guifg=" . s:yellow
exec "hi String guifg=" . s:green
exec "hi Character guifg=" . s:green
exec "hi Number guifg=" . s:yellow
exec "hi Boolean guifg=" . s:yellow
exec "hi Float guifg=" . s:yellow

exec "hi Identifier guifg=" . s:white
exec "hi Function guifg=" . s:blue

exec "hi Statement guifg=" . s:orange
exec "hi Conditional guifg=" . s:orange
exec "hi Repeat guifg=" . s:orange
exec "hi Label guifg=" . s:orange
exec "hi Operator guifg=" . s:white
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
exec "hi Delimiter guifg=" . s:white
exec "hi SpecialComment guifg=" . s:orange
exec "hi Debug guifg=" . s:red

" UI elements
exec "hi Visual guibg=" . s:gray
exec "hi Search guifg=" . s:black . " guibg=" . s:yellow
exec "hi IncSearch guifg=" . s:black . " guibg=" . s:orange
exec "hi StatusLine guifg=" . s:white . " guibg=" . s:gray
exec "hi StatusLineNC guifg=" . s:dim_gray . " guibg=" . s:gray
exec "hi VertSplit guifg=" . s:gray . " guibg=" . s:black
exec "hi Pmenu guifg=" . s:white . " guibg=" . s:gray
exec "hi PmenuSel guifg=" . s:black . " guibg=" . s:orange