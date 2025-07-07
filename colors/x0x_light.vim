" X0X Light theme for Neovim
" Inspired by Roland TR-909 - silver chassis with blue LCD

set background=light

" Define 909-inspired colors
let s:silver = "#f2f2f2"
let s:black = "#1a1a1a"
let s:dark_black = "#000000"
let s:gray = "#dddddd"
let s:dim_gray = "#666666"
let s:blue = "#0066cc"
let s:pink = "#ff3366"
let s:yellow = "#dd8800"
let s:red = "#cc2244"
let s:green = "#228844"
let s:cyan = "#0088aa"
let s:purple = "#8844cc"

" Clear existing highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "x0x-light"

" Editor settings - LCD display aesthetic
exec "hi Normal guifg=" . s:black . " guibg=" . s:silver
exec "hi Cursor guifg=" . s:silver . " guibg=" . s:blue
exec "hi CursorLine guibg=" . s:gray
exec "hi LineNr guifg=" . s:dim_gray . " guibg=" . s:silver
exec "hi CursorLineNr guifg=" . s:blue . " guibg=" . s:gray

" Syntax highlighting - drum machine inspired
exec "hi Comment guifg=" . s:dim_gray
exec "hi Constant guifg=" . s:yellow
exec "hi String guifg=" . s:green
exec "hi Character guifg=" . s:green
exec "hi Number guifg=" . s:yellow
exec "hi Boolean guifg=" . s:blue
exec "hi Float guifg=" . s:yellow

exec "hi Identifier guifg=" . s:black
exec "hi Function guifg=" . s:blue

exec "hi Statement guifg=" . s:blue
exec "hi Conditional guifg=" . s:blue
exec "hi Repeat guifg=" . s:blue
exec "hi Label guifg=" . s:pink
exec "hi Operator guifg=" . s:black
exec "hi Keyword guifg=" . s:blue
exec "hi Exception guifg=" . s:red

exec "hi PreProc guifg=" . s:purple
exec "hi Include guifg=" . s:purple
exec "hi Define guifg=" . s:purple
exec "hi Macro guifg=" . s:cyan
exec "hi PreCondit guifg=" . s:purple

exec "hi Type guifg=" . s:cyan
exec "hi StorageClass guifg=" . s:cyan
exec "hi Structure guifg=" . s:cyan
exec "hi Typedef guifg=" . s:cyan

exec "hi Special guifg=" . s:blue
exec "hi SpecialChar guifg=" . s:blue
exec "hi Tag guifg=" . s:blue
exec "hi Delimiter guifg=" . s:black
exec "hi SpecialComment guifg=" . s:blue
exec "hi Debug guifg=" . s:red

" UI elements - control panel aesthetic
exec "hi Visual guibg=" . s:gray
exec "hi Search guifg=" . s:silver . " guibg=" . s:yellow
exec "hi IncSearch guifg=" . s:silver . " guibg=" . s:blue
exec "hi StatusLine guifg=" . s:black . " guibg=" . s:gray
exec "hi StatusLineNC guifg=" . s:dim_gray . " guibg=" . s:gray
exec "hi VertSplit guifg=" . s:gray . " guibg=" . s:silver
exec "hi Pmenu guifg=" . s:black . " guibg=" . s:gray
exec "hi PmenuSel guifg=" . s:silver . " guibg=" . s:blue