
set nocompatible              " be iMproved, required
filetype off                  " Required before vundle

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
Plugin 'airblade/vim-gitgutter' "show git diff info in airline
" Language extras:
Plugin 'idris-hackers/idris-vim'
Plugin 'neovimhaskell/haskell-vim' 
" HTML Matching tags
Plugin 'gregsexton/matchtag'
" NERDTree
Plugin 'preservim/nerdtree'
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
"
" hybrid line numbers
set ruler
set number relativenumber
set nu rnu

" Use vims default filetype plugins
" see :h ftplugin-doc for defaults for each language
syntax on
" Indent according to rules set by filetype
filetype plugin indent on

" Default, language agonostic tab/spaces indentation rules
" For most languages, this is personal preference, so not built into vim.
" Personal settings per filetype can be found in .vim/after/ftplugin/FILETYPE.vim
" See :h filetype-plugins
set autoindent " When indented, stay indented
set shiftwidth=4 " Number of characters to indent by
set tabstop=4 " Number of characters for tab key
set expandtab " Pressing tab makes 4 spaces.


colorscheme gruvbox
set bg=dark
"let g:indent_guides_enable_on_vim_startup = 1
let g:airline_theme='bubblegum'
