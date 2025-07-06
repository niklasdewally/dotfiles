" default habamax theme but with a modified modeline
"
runtime colors/habamax.vim

let g:colors_name = 'myhabamax'

hi! link StatusLine Normal
hi! link StatusLineNc Normal
hi! VertSplit NONE


" always show horizontal seperators 
" see :h fillchars
set laststatus=3
