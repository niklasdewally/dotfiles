" default habamax theme but with a modified modeline
"
runtime colors/habamax.vim

let g:colors_name = 'myhabamax'

hi! link StatusLine Normal
hi! link StatusLineNc Normal
hi! VertSplit NONE

" make error underlines the correct colour... 
" I manually set the colours to be the same as DiagnosticError,
" DiagnosticWarn, ... by checking :highlight.
hi! DiagnosticUnderlineError gui=undercurl guisp=Red
hi! DiagnosticUnderlineWarn gui=undercurl guisp=Orange
hi! DiagnosticUnderlineInfo gui=undercurl guisp=LightBlue
hi! DiagnosticUnderlineHint gui=undercurl guisp=LightGrey
hi! DiagnosticUnderlineOk gui=undercurl guisp=LightGreen


hi! IblScope ctermfg=Yellow guisp=Yellow

" always show horizontal seperators 
" see :h fillchars
set laststatus=3
