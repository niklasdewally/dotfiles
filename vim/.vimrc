"
" Personal self-installing vim config using vim-plug.
"
"INSTALLATION:
" Rename this file .vimrc and place it in your home folder.
"
" On first run, the vim-plug plugin manager and plugins will be automatically
" installed into ~/.vim.
" 
" (if installing on the cs servers, you might need to mkdir
" /cs/home/<username>/.vim before doing this.)
"
" Written 19/11/21 by nd60


set nocompatible " be vIM not vi!

""""""""""""""""""""""""""""""""""""
" Autoinstall vim-plug and plugins "
""""""""""""""""""""""""""""""""""""
" Copied from https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" Best not to touch this!

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


"""""""""""
" Plugins "
"""""""""""
" See: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" PLACE PLUGINS HERE!
Plug 'morhetz/gruvbox' " my preferred colorscheme :)

" Markdown Plugins
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim'
" Latex
Plug 'lervag/vimtex'
" Discord Rich Presence
Plug 'vimsence/vimsence'
" Readability 
Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline' " nice bottom bar
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter' " show git diff info in airline
" Language Extras
Plug 'gregsexton/matchtag' " match HTML tags

call plug#end()
"""""""""""""""""
" Line Numbers  "
"""""""""""""""""
set ruler
"set nu 
" Use this if you want the current line to show the line number, but the
" others to show distance from the current line - this is useful for vim
" commands (eg 10j)!
set nu rnu


"""""""""""""""""""""""""""""""""""""""
" Indentation and Syntax Highlighting "
"""""""""""""""""""""""""""""""""""""""
" Uses vims default filetype settings - providing indentation and/or plugins.
" You can also make your own filetype plugins - see the docs and google for
" more deatails.
"
" See: :h filetype.

" Personal settings per filetype can be put in .vim/after/ftplugin/FILETYPE.vim
" Write these like any vimrc file, but use setlocal instead of set.
"
" See: :h filetype-plugins

syntax on
filetype plugin indent on

" Default, language agonostic tab/spaces indentation rules
" For most languages, this is personal preference, so not built into vim.
" (however, python uses pep8 defaults)

set autoindent " When indented, stay indented
set shiftwidth=4 " Number of characters to indent by
set tabstop=4 " Number of characters for tab key
set expandtab " Pressing tab makes 4 spaces.

"""""""""""""""""
" Colour-scheme "
"""""""""""""""""
" See the documentation for your preferred color-scheme for what to put here!
" for gruvbox (my scheme of choice): https://github.com/morhetz/gruvbox

set bg=dark " options: dark | light
colorscheme gruvbox
let g:airline_theme='gruvbox'
