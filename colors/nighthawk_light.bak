" Nighthawk Light theme for Neovim
" Monochromatic slate theme balanced for all lighting conditions

set background=light

" Define monochromatic slate colors
let s:lightest = "#f8f9fa"
let s:panel = "#e2e8f0"
let s:lighter = "#cbd5e0"
let s:light = "#a0aec0"
let s:medium_light = "#718096"
let s:medium = "#4a5568"
let s:dark = "#2d3748"
let s:darkest = "#1a202c"

" Clear existing highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "nighthawk-light"

" Editor settings - monochromatic focus
exec "hi Normal guifg=" . s:dark . " guibg=" . s:lightest
exec "hi Cursor guifg=" . s:lightest . " guibg=" . s:medium
exec "hi CursorLine guibg=" . s:panel
exec "hi LineNr guifg=" . s:medium_light . " guibg=" . s:lightest
exec "hi CursorLineNr guifg=" . s:medium . " guibg=" . s:panel

" Syntax highlighting - all in slate spectrum for focus
exec "hi Comment guifg=" . s:medium_light
exec "hi Constant guifg=" . s:light
exec "hi String guifg=" . s:medium_light
exec "hi Character guifg=" . s:medium_light
exec "hi Number guifg=" . s:light
exec "hi Boolean guifg=" . s:medium
exec "hi Float guifg=" . s:light

exec "hi Identifier guifg=" . s:dark
exec "hi Function guifg=" . s:darkest

exec "hi Statement guifg=" . s:medium
exec "hi Conditional guifg=" . s:medium
exec "hi Repeat guifg=" . s:medium
exec "hi Label guifg=" . s:light
exec "hi Operator guifg=" . s:dark
exec "hi Keyword guifg=" . s:medium
exec "hi Exception guifg=" . s:darkest

exec "hi PreProc guifg=" . s:light
exec "hi Include guifg=" . s:light
exec "hi Define guifg=" . s:light
exec "hi Macro guifg=" . s:medium_light
exec "hi PreCondit guifg=" . s:light

exec "hi Type guifg=" . s:medium_light
exec "hi StorageClass guifg=" . s:medium_light
exec "hi Structure guifg=" . s:medium_light
exec "hi Typedef guifg=" . s:medium_light

exec "hi Special guifg=" . s:medium
exec "hi SpecialChar guifg=" . s:medium
exec "hi Tag guifg=" . s:medium
exec "hi Delimiter guifg=" . s:dark
exec "hi SpecialComment guifg=" . s:medium
exec "hi Debug guifg=" . s:darkest

" UI elements - clean monochromatic
exec "hi Visual guibg=" . s:panel
exec "hi Search guifg=" . s:lightest . " guibg=" . s:light
exec "hi IncSearch guifg=" . s:lightest . " guibg=" . s:medium
exec "hi StatusLine guifg=" . s:dark . " guibg=" . s:panel
exec "hi StatusLineNC guifg=" . s:medium_light . " guibg=" . s:panel
exec "hi VertSplit guifg=" . s:panel . " guibg=" . s:lightest
exec "hi Pmenu guifg=" . s:dark . " guibg=" . s:panel
exec "hi PmenuSel guifg=" . s:lightest . " guibg=" . s:medium