" hybrid line numbers
:set ruler
:set number relativenumber
:set nu rnu

" Use vims default filetype plugins
" see :h ftplugin-doc for defaults for each language
filetype plugin indent on
" Python https://www.vimfromscratch.com/articles/vim-for-python/
:  
au BufNewFile,BufRead *.py
    \ set expandtab        |
    \ set autoindent       |
    \ set tabstop=4        |
    \ set softtabstop=4    |
    \ set shiftwidth=4     


set nocompatible              " be iMproved, required
filetype off                  " required


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
" Markdown plugins
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/markdown-preview.nvim' 
" Latex!
Plugin 'lervag/vimtex'
" Rich Presence
Plugin 'vimsence/vimsence'
"Readability Stuff
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
:colorscheme gruvbox
:set bg=dark
let g:indent_guides_enable_on_vim_startup = 1
let g:airline_theme='bubblegum'
