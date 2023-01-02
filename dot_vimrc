" vim: fdm=marker ft=vim

" Written 19/11/21 by nd60
" (updated 02/01/23)

" Vim-plug setup {{{ 
    " Install vim-plug if not found
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif

    " Run PlugInstall if there are missing plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
    \| endif
" }}}
" Plugins {{{ 

    " See: https://github.com/junegunn/vim-plug
    call plug#begin('~/.vim/plugged')

    Plug 'vimsence/vimsence' " Discord Rich Presence

    " Aesthetics
    Plug 'morhetz/gruvbox' " my preferred colorscheme :)
    Plug 'vim-airline/vim-airline' " nice bottom bar
    Plug 'vim-airline/vim-airline-themes'
    Plug 'airblade/vim-gitgutter' " show git diff info in airline

    " Navigation
    Plug 'preservim/nerdtree' " File browsing
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}

    " REPL Integration
    Plug 'jpalardy/vim-slime' "REPL integration (see later section in this file)

    " Markdown Writing
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'dhruvasagar/vim-table-mode'

    " Racket / Scheme
    " See: https://docs.racket-lang.org/guide/Vim.html
    Plug 'benknoble/vim-racket' " basic language plugin
    Plug 'kien/rainbow_parentheses.vim'
    " use this one for emacs-paredit like functionality (auto close brackets, plus
    " some other vim keybindings!) - it also supports REPL stuff, but not for
    " racket!
    Plug 'kovisoft/slimv'

    " HTML / CSS
    Plug 'gregsexton/matchtag' " match HTML tags

    " Haskell
    Plug 'neovimhaskell/haskell-vim'
    Plug 'monkoose/fzf-hoogle.vim'

    call plug#end()
" }}}
" Editor {{{

    set nocompatible " be vim not vi
    set incsearch
	set backspace=indent,eol,start
    set showcmd

    " Line numbers
    set ruler
    set nu rnu
    
    if has('persistent_undo') 
        set undofile
    endif
" }}}
" Editor: Colour Scheme {{{ 

    set bg=dark
    colorscheme gruvbox
    let g:airline_theme='gruvbox'

" }}}
" Editor: Indentation and Syntax Highlighting {{{ 

    set autoindent " When indented, stay indented
    set shiftwidth=4 " Number of characters to indent by
    set tabstop=4 " Number of characters for tab key
	set expandtab

    filetype plugin indent on
    syntax on

" }}}
" {{{ Keybindings 
    let mapleader=","
    let maplocalleader=" "
" }}}
" Keybindings: Splits {{{ 
    " create new splits
    nnoremap <leader>v :vne
    nnoremap <leader>s :split
    " move between splits
    nnoremap <leader>j <C-w>j
    " gitgutter causes a conflict - disable keybindings
    let g:gitgutter_map_keys = 0
    nnoremap <leader>h <C-w>h
    nnoremap <leader>k <C-w>k
    nnoremap <leader>l <C-w>l
    " move around splits (to specified side of screen)
    nnoremap <leader>J <C-w>J
    nnoremap <leader>H <C-w>H
    nnoremap <leader>K <C-w>K
    nnoremap <leader>L <C-w>L
    " resize vsplits
    nnoremap <leader>< <c-w><
    nnoremap <leader>> <c-w>>
" }}}
" Keybindings: No Crutches {{{

    noremap <Left> <Nop>
    noremap <Right> <Nop>
    noremap <Up> <Nop>
    noremap <Down> <Nop>

    noremap <kPageUp> <Nop>
    noremap <kPageDown> <Nop>

" }}}
" Keybindings: File Commands (Leader-F) {{{
    
	" File Find
    nnoremap <leader>f  :echo "(f)ile \|\|  (f)ind - open the file tree   (s)earch - open fzf"<CR>
    nnoremap <leader>f? :echo "(f)ile \|\|  (f)ind - open the file tree   (s)earch - open fzf"<CR>
    nnoremap <leader>ff :NERDTree<CR>
	let NERDTreeQuitOnOpen='3' " autoclose nerdtree after opening a file

	" File Search
    " https://sourcediving.com/better-fuzzy-finding-in-vim-2f1e8597b3b9
    nnoremap <leader>fs :FZF<CR>

" }}}
" Keybindings: Haskell Mode {{{

    autocmd FileType haskell call s:SetHaskellKeyBindings()
    function SetHaskellKeyBindings() 
        " clear all existing filetype keybindings
        mapclear <buffer>
        mapclear! <buffer>
        nnoremap <buffer> <LocalLeader>  :echo "(h)oogle"<CR>
        nnoremap <LocalLeader>? :echo "(h)oogle"<CR>
        nnoremap <LocalLeader>h :Hoogle<CR>
    endfunction

" }}}
" Languages: Markdown / Pandoc {{{ 
"
    let g:pandoc#syntax#codeblocks#embed#langs = ["html","c","css","java","bash=sh"]
	let g:pandoc#formatting#mode = 'ha' "  hardwrap
	let g:pandoc#smart_autoformat_on_cursormoved = 1
	" This plugin can suggest citations using CTRL-X CTRL-O !
	
" }}}
" Languages: Haskell {{{
   let g:haskell_indent_disable = 0

   " Folds
   au FileType haskell {
       setl foldmethod=marker
   }
" }}}
" Languages: REPL Support {{{ 
    " See: https://github.com/jpalardy/vim-slime
    " This plugin allows Ctrl-c c (holding ctrl) to send the selected code over to
    " a REPL (eg. racket, R) in another tmux pane
    "
    " Configuration for tmux (see README):
    let g:slime_target = "tmux"
    let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
" }}}
" References {{{ 
"   -  https://medium.com/usevim/folding-a-vimrc-1aee3d69cb6d
"   -  https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file
" }}}
