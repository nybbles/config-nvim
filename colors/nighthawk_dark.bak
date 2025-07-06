" Nighthawk Dark theme for Neovim
" Night vision optimized - red spectrum on black for scotopic vision preservation

set background=dark

" Define night vision colors (red spectrum only)
let s:black = "#000000"
let s:red = "#cc6666"
let s:dark_red = "#aa4444"
let s:light_red = "#ff8888"
let s:gray = "#444444"
let s:light_gray = "#666666"
let s:mid_gray = "#888888"
let s:panel = "#222222"
let s:dim = "#664444"

" Clear existing highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "nighthawk-dark"

" Editor settings - pure night vision
exec "hi Normal guifg=" . s:red . " guibg=" . s:black
exec "hi Cursor guifg=" . s:black . " guibg=" . s:dark_red
exec "hi CursorLine guibg=" . s:panel
exec "hi LineNr guifg=" . s:light_gray . " guibg=" . s:black
exec "hi CursorLineNr guifg=" . s:dark_red . " guibg=" . s:panel

" Syntax highlighting - all in red spectrum for night vision
exec "hi Comment guifg=" . s:light_gray
exec "hi Constant guifg=" . s:mid_gray
exec "hi String guifg=" . s:light_gray
exec "hi Character guifg=" . s:light_gray
exec "hi Number guifg=" . s:mid_gray
exec "hi Boolean guifg=" . s:dark_red
exec "hi Float guifg=" . s:mid_gray

exec "hi Identifier guifg=" . s:red
exec "hi Function guifg=" . s:light_red

exec "hi Statement guifg=" . s:dark_red
exec "hi Conditional guifg=" . s:dark_red
exec "hi Repeat guifg=" . s:dark_red
exec "hi Label guifg=" . s:mid_gray
exec "hi Operator guifg=" . s:red
exec "hi Keyword guifg=" . s:dark_red
exec "hi Exception guifg=" . s:light_red

exec "hi PreProc guifg=" . s:mid_gray
exec "hi Include guifg=" . s:mid_gray
exec "hi Define guifg=" . s:mid_gray
exec "hi Macro guifg=" . s:light_gray
exec "hi PreCondit guifg=" . s:mid_gray

exec "hi Type guifg=" . s:light_gray
exec "hi StorageClass guifg=" . s:light_gray
exec "hi Structure guifg=" . s:light_gray
exec "hi Typedef guifg=" . s:light_gray

exec "hi Special guifg=" . s:dark_red
exec "hi SpecialChar guifg=" . s:dark_red
exec "hi Tag guifg=" . s:dark_red
exec "hi Delimiter guifg=" . s:red
exec "hi SpecialComment guifg=" . s:dark_red
exec "hi Debug guifg=" . s:light_red

" UI elements - minimal for night operations
exec "hi Visual guibg=" . s:panel
exec "hi Search guifg=" . s:black . " guibg=" . s:mid_gray
exec "hi IncSearch guifg=" . s:black . " guibg=" . s:dark_red
exec "hi StatusLine guifg=" . s:red . " guibg=" . s:panel
exec "hi StatusLineNC guifg=" . s:light_gray . " guibg=" . s:panel
exec "hi VertSplit guifg=" . s:panel . " guibg=" . s:black
exec "hi Pmenu guifg=" . s:red . " guibg=" . s:panel
exec "hi PmenuSel guifg=" . s:black . " guibg=" . s:dark_red