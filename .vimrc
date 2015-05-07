" vim-tiny, vim-smallの場合、設定をスキップ
if !1 | finish | endif


""""""""""""""""""""""""""""""
" 基本設定
""""""""""""""""""""""""""""""

syntax on
colorscheme desert
set autoindent
set backspace=indent,eol,start
set clipboard+=unnamed
set nocompatible
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
if has("mouse")
  set mouse=a
  set ttymouse=xterm2
endif

set laststatus=2
" set statusline=%{fugitive#statusline()}                              " gitのステータス
set statusline+=\ %<
set statusline+=\ %f                                                 " ファイル名(相対パス)
set statusline+=\ %m                                                 " 修正を表すフラグ(+ OR -)
set statusline+=%r                                                   " 読み込み専用フラグ
set statusline+=%h                                                   " ヘルプフラグ
set statusline+=%w                                                   " プレビューウィンドウフラグ
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}   " ファイルエンコーディング・ファイルフォーマット
set statusline+=%=                                                   " 以降右寄せ
set statusline+=%l/%L,%c%V                                           " 現在の行 / 総行数, 現在列
set statusline+=%8P                                                  " カーソル位置%

" 行末移動を簡単に
nnoremap 1 $

" Escを簡単に
inoremap jj <ESC>
onoremap jj <ESC>
vnoremap jj <ESC>

" window分割
nnoremap <Space>- <C-w>s
nnoremap <Space>\| <C-w>v

" window拡大・縮小
nnoremap <Space>+- 5<C-w>+
nnoremap <Space>-- 5<C-w>-
nnoremap <Space>+\| 5<C-w>>
nnoremap <Space>-\| 5<C-w><

" 最後に編集した際のカーソル位置を復元
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge

" grep時にQuickFixウィンドウを開く
autocmd QuickFixCmdPost *grep* copen

" 全角スペースを強調
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/


""""""""""""""""""""""""""""""
" プラグイン
""""""""""""""""""""""""""""""

" NeoBundle
" See https://github.com/Shougo/neobundle.vim

if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" ファイラ
NeoBundle 'Shougo/unite.vim'
" unite.vimで最近使ったファイルを表示
NeoBundle 'Shougo/neomru.vim'
" Rails向けuniteコマンドを提供
NeoBundle 'basyura/unite-rails'
" 補完
if has("lua")
  NeoBundle 'Shougo/neocomplete.vim'
endif
" ファイルをツリー表示
NeoBundle 'scrooloose/nerdtree'
" Gitを便利に
NeoBundle 'tpope/vim-fugitive'
" Controller-Model間のファイル移動などを便利に
NeoBundle 'tpope/vim-rails'
" Ctrl+- を2回押すと選択行をコメントアウト
NeoBundle 'tomtom/tcomment_vim'
" 対になるendを自動で挿入
NeoBundle 'tpope/vim-endwise'
" Vimの日本語ドキュメント
NeoBundle 'vim-jp/vimdoc-ja'
" HTML、CSSの記述を効率化'
NeoBundle 'mattn/emmet-vim'
" シングル-ダブルクォート間の置換など
NeoBundle 'tpope/vim-surround'
" *を押すとvisualモードで選択した文字列を検索
NeoBundle 'nelstrom/vim-visual-star-search'
" 構文解析インターフェイス
NeoBundle 'scrooloose/syntastic'
" true-falseなどの切替を便利に
NeoBundle 'AndrewRadev/switch.vim'
" エディタ上のURLを開く or 選択範囲をgoogle検索
NeoBundle 'tyru/open-browser.vim'
" シンタックス & コンパイル & 静的解析
NeoBundle 'kchmck/vim-coffee-script'
" SCSSシンタックス
NeoBundle 'cakebaker/scss-syntax.vim'
" slim シンタックス
NeoBundle "slim-template/vim-slim"
call neobundle#end()
filetype plugin indent on
NeoBundleCheck

""""""""""""""""""""""""""""""
" プラグインの設定
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" unite
""""""""""""""""""""""""""""""

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


""""""""""""""""""""""""""""""
" unite-rails
""""""""""""""""""""""""""""""

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


""""""""""""""""""""""""""""""
" neocomplete.vim
""""""""""""""""""""""""""""""

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif


""""""""""""""""""""""""""""""
" syntastic
""""""""""""""""""""""""""""""

" 常に規約違反を表示
"let g:syntastic_always_populate_loc_list=1
" 規約違反時にエラーウィンドウを開く
"let g:syntastic_auto_loc_list=1
" ファイルを開いた際に規約違反をチェック
"let g:syntastic_check_on_open=0
" wqコマンド実行時はチェックしない
"let g:syntastic_check_on_wq=0
" 各言語ごとの設定
"let g:syntastic_ruby_checkers = ['rubocop']
"let g:syntastic_haml_checkers = ['haml_lint']
"let g:syntastic_scss_checkers = ['scss_lint']
"let g:syntastic_coffee_checkers = ['coffeelint']
"let g:syntastic_ruby_rubocop_args = "-c ~/.lint/.rubocop.yml"
"let g:syntastic_haml_haml_lint_args = "-c ~/.lint/.haml-lint.yml"
"let g:syntastic_scss_scss_lint_args = "-c ~/.lint/.scss-lint.yml"
"let g:syntastic_coffee_coffeelint_args = "--file ~/.lint/.coffeelint.json"


""""""""""""""""""""""""""""""
" vim-coffee-script
""""""""""""""""""""""""""""""

" コンパイル後のjsをプレビューする
" cnoremap cw CoffeeWatch vert <CR>


""""""""""""""""""""""""""""""
" open-browser.vim
""""""""""""""""""""""""""""""

" カーソル下のURLをブラウザで開く
nmap <Space>o <Plug>(openbrowser-open)
vmap <Space>o <Plug>(openbrowser-open)
" Googleで検索
nnoremap <Space>og :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>

""""""""""""""""""""""""""""""
" emmet
""""""""""""""""""""""""""""""
let g:user_emmet_leader_key='<C-e>'

