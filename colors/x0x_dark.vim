" X0X Dark theme for Neovim
" Inspired by Roland TR-808 - classic drum machine with orange accents

set background=dark

" Define 808-inspired colors
let s:black = "#101010"
let s:white = "#e8e8e8"
let s:bright_white = "#ffffff"
let s:gray = "#2a2a2a"
let s:dim_gray = "#888888"
let s:orange = "#ff6600"
let s:green = "#00ff88"
let s:yellow = "#ffcc00"
let s:red = "#ff3333"
let s:blue = "#3388ff"
let s:pink = "#ff44cc"
let s:cyan = "#00ccff"

" Clear existing highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "x0x-dark"

" Editor settings - LCD display aesthetic
exec "hi Normal guifg=" . s:white . " guibg=" . s:black
exec "hi Cursor guifg=" . s:black . " guibg=" . s:orange
exec "hi CursorLine guibg=" . s:gray
exec "hi LineNr guifg=" . s:dim_gray . " guibg=" . s:black
exec "hi CursorLineNr guifg=" . s:orange . " guibg=" . s:gray

" Syntax highlighting - drum machine inspired
exec "hi Comment guifg=" . s:dim_gray
exec "hi Constant guifg=" . s:yellow
exec "hi String guifg=" . s:green
exec "hi Character guifg=" . s:green
exec "hi Number guifg=" . s:yellow
exec "hi Boolean guifg=" . s:orange
exec "hi Float guifg=" . s:yellow

exec "hi Identifier guifg=" . s:white
exec "hi Function guifg=" . s:blue

exec "hi Statement guifg=" . s:orange
exec "hi Conditional guifg=" . s:orange
exec "hi Repeat guifg=" . s:orange
exec "hi Label guifg=" . s:pink
exec "hi Operator guifg=" . s:white
exec "hi Keyword guifg=" . s:orange
exec "hi Exception guifg=" . s:red

exec "hi PreProc guifg=" . s:pink
exec "hi Include guifg=" . s:pink
exec "hi Define guifg=" . s:pink
exec "hi Macro guifg=" . s:cyan
exec "hi PreCondit guifg=" . s:pink

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

" UI elements - control panel aesthetic
exec "hi Visual guibg=" . s:gray
exec "hi Search guifg=" . s:black . " guibg=" . s:yellow
exec "hi IncSearch guifg=" . s:black . " guibg=" . s:orange
exec "hi StatusLine guifg=" . s:white . " guibg=" . s:gray
exec "hi StatusLineNC guifg=" . s:dim_gray . " guibg=" . s:gray
exec "hi VertSplit guifg=" . s:gray . " guibg=" . s:black
exec "hi Pmenu guifg=" . s:white . " guibg=" . s:gray
exec "hi PmenuSel guifg=" . s:black . " guibg=" . s:orange