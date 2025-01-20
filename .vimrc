set nocompatible
filetype on
filetype plugin on
filetype indent on

syntax on
set number
set relativenumber
set shiftwidth=2
set tabstop=2
set expandtab
let NERDTreeShowHidden=1

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'

call plug#end()

inoremap jj <esc>
nnoremap <C-n> :NERDTreeToggle<CR>
