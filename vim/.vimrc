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


"          "
" Function "
"          " 

set number
set relativenumber
set encoding=utf-8
set laststatus=2
set tabstop=5
set shiftwidth=5
set expandtab
set clipboard=unnamedplus
