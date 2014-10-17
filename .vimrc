syntax on
set autoindent
set confirm
set expandtab
set hidden
set hlsearch
set incsearch
set number
set ruler
set list
set noswapfile
set shiftwidth=2
set showcmd
set showmatch
set smartindent
set smarttab
set tabstop=2
set wildmenu

" Setting of NeoBundle
" See https://github.com/Shougo/neobundle.vim
if !1 | finish | endif

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" My bundles here
