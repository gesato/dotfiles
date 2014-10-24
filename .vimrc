""""""""""""""""""""""""""""""
" 基本設定
""""""""""""""""""""""""""""""

syntax on
colorscheme desert
set autoindent
set backspace=indent,eol,start
set clipboard+=unnamed
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
set title
set tabstop=2
set wildmenu

set laststatus=2 
set statusline=%{fugitive#statusline()}
set statusline+=\ %<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

" かっこの終端を自動入力
imap [ []<Left>
imap { {}<Left>
imap ( ()<Left>

" 最後に編集した際のカーソル位置を復元
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

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
NeoBundle 'Shougo/neocomplete.vim'
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
NeoBundle 'scrooloose/syntastic'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

""""""""""""""""""""""""""""""
" プラグインの設定
""""""""""""""""""""""""""""""

" unite
" insertモードから開始
let g:unite_enable_start_insert=1
" yank履歴をuniteから呼び出す
let g:unite_source_history_yank_enable = 1

" ESCキーを2回押すとuniteを終了させる
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

nmap <Space> [unite]
nnoremap <silent> [unite]b :Unite buffer<CR>
nnoremap <silent> [unite]f :Unite -buffer-name=file file<CR>
nnoremap <silent> [unite]u :Unite file_mru<CR>
nnoremap <silent> [unite]h :Unite history/yank<CR>


" unite-rails
nnoremap <silent>[unite]m :Unite rails/model<CR>
nnoremap <silent>[unite]v :Unite rails/view<CR>
nnoremap <silent>[unite]c :Unite rails/controller<CR>
nnoremap <silent>[unite]j :Unite rails/javascript<CR>
nnoremap <silent>[unite]y :Unite rails/stylesheet<CR>

nnoremap <silent>[unite]g :Unite rails/config<CR>
nnoremap <silent>[unite]s :Unite rails/spec<CR>
nnoremap <silent>[unite]d :Unite rails/db -input=migrate<CR>
nnoremap <silent>[unite]l :Unite rails/lib<CR>
nnoremap <silent>[unite]t :Unite rails/rake<CR>
nnoremap <silent>[unite]r :Unite rails/route<CR>

" neocomplete.vim
let g:neocomplete#enable_at_startup=1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

" auto-ctags
" バッファ保存時に自動的にCtagを作成
let g:auto_ctags=1


" syntastic
let g:syntastic_mode_map = {
  \ 'mode': 'passive',
  \ 'active_filetypes': ['ruby']
\ }
let g:syntastic_ruby_checkers = ['rubocop']


" open-browser.vim
" カーソル下のURLをブラウザで開く
nmap <Space>o <Plug>(openbrowser-open)
vmap <Space>o <Plug>(openbrowser-open)

" Googleで検索
nnoremap <Space>og :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>


" simple-javascript-indenter
" switch文のインデントを綺麗にする
let g:SimpleJsIndenter_CaseIndentLevel=-1
