""""""""""""""""""""""""""""""
" 基本設定
""""""""""""""""""""""""""""""

syntax on
colorscheme desert
set autoindent
set confirm
set expandtab
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set list
set listchars=tab:»-,trail:-,eol:.
set number
set ruler
set noswapfile
set shiftwidth=2
set showcmd
set showmatch
set smartcase
set smartindent
set smarttab
set tabstop=2
set wildmenu

" かっこの終端を自動入力
imap [ []<Left>
imap { {}<Left>
imap ( ()<Left>

" grep時にQuickFixウィンドウを開く
autocmd QuickFixCmdPost *grep* copen

" 全角スペースを強調
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
  augroup END
  call ZenkakuSpace()
endif


""""""""""""""""""""""""""""""
" プラグイン
""""""""""""""""""""""""""""""

" NeoBundle
" See https://github.com/Shougo/neobundle.vim
if !1 | finish | endif

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" My bundles here
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'basyura/unite-rails'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'nelstrom/vim-visual-star-search'
NeoBundle 'soramugi/auto-ctags.vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

""""""""""""""""""""""""""""""
" プラグインの設定
""""""""""""""""""""""""""""""

" unite
" insertモードから開始
let g:unite_enable_start_insert=1

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

nmap <Space> [unite]
nnoremap <silent> [unite]b :Unite buffer<CR>
nnoremap <silent> [unite]f :Unite -buffer-name=file file<CR>
nnoremap <silent> [unite]u :Unite file_mru<CR>

" unite-rails
nnoremap <silent>[unite]m :Unite rails/model<CR>
nnoremap <silent>[unite]v :Unite rails/view<CR>
nnoremap <silent>[unite]c :Unite rails/controller<CR>
nnoremap <silent>[unite]h :Unite rails/helper<CR>
nnoremap <silent>[unite]j :Unite rails/javascript<CR>
nnoremap <silent>[unite]y :Unite rails/stylesheet<CR>

nnoremap <silent>[unite]g :Unite rails/config<CR>
nnoremap <silent>[unite]s :Unite rails/spec<CR>
nnoremap <silent>[unite]d :Unite rails/db -input=migrate<CR>
nnoremap <silent>[unite]l :Unite rails/lib<CR>
nnoremap <silent>[unite]t :Unite rails/rake<CR>
nnoremap <silent>[unite]r :Unite rails/route<CR>

" auto-ctags
" バッファ保存時に自動的にCtagを作成
let g:auto_ctags=1
