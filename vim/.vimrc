"        "
" Vundle "
"        "


set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'lilydjwg/colorizer'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'yuttie/comfortable-motion.vim'
Bundle 'withgod/vim-sourcepawn.git'
Plugin 'maxboisvert/vim-simple-complete'
Plugin 'tommcdo/vim-lion'

call vundle#end() 
filetype plugin indent on


"            "
" Appearance "
"            "


syntax on
let g:airline_powerline_fonts = 0
let g:airline_theme='base16_eighties'
let g:airline_left_sep = ''
let g:airline_right_sep = ''

highlight Pmenu ctermbg=0 ctermfg=8
highlight PmenuSel ctermbg=0 ctermfg=4


"          "
" Function "
"          " 


set background=dark
set number
set relativenumber
set encoding=utf-8
set laststatus=2
set tabstop=5
set shiftwidth=5
set expandtab
set autoindent
set clipboard=unnamedplus


"            "
" Completion "
"            "


let g:vsc_tab_complete = 1
let g:vsc_type_complete = 1
let g:vsc_completion_command = "\<C-P>"
let g:vsc_reverse_completion_command = "\<C-N>"
let g:vsc_type_complete_length = 1
