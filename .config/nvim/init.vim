" 初期化{{{
if &compatible
  set encoding=utf-8
  set nocompatible
endif
"}}}

" ヘルプを日本語に変更
set helplang=ja

let mapleader = "\<Space>"

" dein {{{
augroup MyAutoCmd
autocmd!
augroup END
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.config/nvim')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  if !exists("g:gui_oni")
    call dein#save_state()
  endif

  call dein#add('Shougo/vimproc.vim', {
    \ 'build': {
    \     'mac': 'make -f make_mac.mak',
    \     'linux': 'make',
    \     'unix': 'gmake',
    \    },
    \ })
endif

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"}}}

let vim_markdown_preview_github = 1

let g:sonictemplate_vim_template_dir = [
      \ '~/git/template'
      \]

let g:sonictemplate_vim_template_dir = [
  \ '$HOME/.config/nvim/template'
  \]

" エンコーディング {{{
" Encoding
scriptencoding=utf-8
set termencoding=utf-8

set fileencodings=utf-8,ucs-bom,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set fileformats=unix,dos,mac
"}}}

" 基本設定{{{
" 行番号を表示する
set number
"ファイル内の <Tab> が対応する空白の数
set tabstop=4
"シフト移動幅
set shiftwidth=4
" 全角記号を正しく扱う
set ambiwidth=double
" Beep音を消す(ヴィジュアルベルを無効)
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
"クリップボード共有
set clipboard+=unnamedplus
" INSERTなどモードの表示をしない
set noshowmode
set inccommand=split
" diff
set diffopt+=vertical

"set termguicolors {{{
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let &t_SI = "\e]50;CursorShape=1\x7"
let &t_EI = "\e]50;CursorShape=0\x7"
"}}}

"日本語設定 {{{
" ノーマルモードに戻った時に日本語入力をオフにする(MAC用)
set imdisable
" }}}

"設定{{{
"バックアップファイルを作るディレクトリ
set backupdir=~/.tmp
"スワップファイルを作るディレクトリ
set directory=~/.tmp
"undoファイル
"set undodir=~/.tmp
"折りたたみ設定(manual,marker,indent)
set foldmethod=manual
set foldlevel=1
set foldnestmax=2
set foldcolumn=2
"CTRL-aで8進数の計算をさせない
set nrformats-=octal

" Vimの外部で変更されたことが判明したとき、自動的に読み直す
set autoread
augroup vimrc-checktime
  autocmd!
  autocmd BufWritePost * sleep 1
  autocmd BufWritePost * checktime
augroup END

" 行を跨いで移動出来るようにする
set whichwrap=b,s,h,l,<,>,[,],~

" インサートモードから抜ける時にnopasteに変更
" set paste
autocmd InsertLeave * set nopaste
" }}}

" 補完{{{
" コマンドライン補完するときに強化されたものを使う
set wildmenu
"コマンド補完
set wildmode=full
" 補完メニューの最大件数
" }}}

" 見栄え{{{
set pumheight=10
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" 対応する括弧に移動する時間0.1秒
set matchtime=1
"カーソルラインを表示
set cursorline
"カーソルカラムを表示（縦線）
set nocursorcolumn
" アンダーラインを引く(color terminal)
autocmd VimEnter,ColorScheme * highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
autocmd VimEnter,ColorScheme * highlight CursorLine gui=underline guifg=NONE guibg=NONE

autocmd InsertEnter * highlight CursorLine cterm=bold
autocmd InsertEnter * highlight CursorLine gui=bold
autocmd InsertLeave * highlight CursorLine cterm=underline
autocmd InsertLeave * highlight CursorLine gui=underline

" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:»-,trail:_
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 全角スペースを可視化
augroup highlight ZenkakuSpace
  autocmd!
  autocmd VimEnter,ColorScheme * highlight ZenkakuSpace term=underline ctermbg=darkcyan guibg=#063642
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
augroup END

hi ZenkakuSpace term=underline ctermbg=darkcyan guibg=#063642

" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 長い行も表示する
set display=lastline
" 常にステータス行を表示
set laststatus=2
" コマンドラインの高さ
set cmdheight=1
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
set splitbelow
set splitright
" }}}

" インデント {{{
" 自動インデント
set autoindent
"新しい行を作るときに高度な自動インデントを行う
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" 矩形選択で文字のないところにカーソル移動できるようにする
set virtualedit=block
" }}}

" 検索{{{
" インクリメンタルサーチを使う
set incsearch
" 検索語にマッチした単語をハイライトする
set hlsearch
" 検索時に大文字小文字を区別しない
set ignorecase
" 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set smartcase
"}}}

" GUI設定 {{{
"横スクロール
set guioptions+=b
"スクロール開始位置を変更
set scrolloff=10
" }}}

" キーマップ設定 {{{
" 保存
nnoremap <Leader>w :w<CR>

" コピー
noremap Y y$

" ペースト
inoremap <C-v> <ESC>"*pa
cnoremap <C-v> <C-r>+
vnoremap <C-p> I<C-r>"<ESC><ESC>

" MAC(emacsキーバインド)と同じ動きにする設定 {{{
" 削除
" カーソルから行の末尾までを消す
"inoremap <silent> <C-k> _<ESC>d$a

" カーソルから行頭まで削除
" <C-u>にデフォルトでマッピング

" カーソルの左側の文字を削除(backspace)
" <C-h>にデフォルトでマッピング

" カーソル右側の文字を削除
"inoremap <C-d> <Del>

" 左右の文字を入れ替える
"inoremap <C-t> <ESC>xpi
" 空行の挿入
"inoremap <C-o> <CR>
" 前の行に空行を挿入
"inoremap <C-O> <ESC>O
" 空行の挿入
"inoremap <C-m> <CR>
" カーソルが中央になるようにスクロール
"inoremap <C-l> <ESC>zzi

" 移動
" カーソルを行頭へ
"inoremap <C-a> <ESC>0i
" カーソルを行末へ
"inoremap <C-e> <ESC>A
" カーソルを左へ
"inoremap <C-b> <Left>
" カーソルを右へ
"inoremap <C-f> <Right>
" }}}

" バッファ切り替え
nnoremap H :<C-u>bp<CR>
nnoremap L :<C-u>bn<CR>
nnoremap <C-Down> :<C-u>buffers<CR>

nnoremap <Leader>v :<C-u>vsplit<CR><C-w><C-w>:ls<CR>:buffer<Space>
nnoremap <Leader>V :<C-u>Vexplore!<CR><CR>
" マーク
"nnoremap <Leader>m :marks<CR>:mark<Space>
"
" タブ
" タブ切り替え
nnoremap <silent> <C-l> gt
nnoremap <silent> <C-h> gT
nnoremap <Leader>t :<C-u>tabnew<CR>
nnoremap <Leader>T :<C-u>tabnew<CR>:e .<CR>

" init.vimを開く
nnoremap <Leader>. :<C-u>tabnew ~/.config/nvim/init.vim<CR>
" dein.tomlを開く
nnoremap <Leader>, :<C-u>tabnew ~/.config/nvim/dein.toml<CR> :<C-u>tabnew ~/.config/nvim/dein_lazy.toml<CR>gT
" init.vim再読込編集
nnoremap <Leader>s :<C-u>source ~/.config/nvim/init.vim<CR>

 " 検索結果のハイライトを消す
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>

" insertモードを抜ける
inoremap <C-j> <esc>

" 入力補助
inoremap `` ``<Left>
inoremap <> <><Left>
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap %% %%<Left>

" 連続インデント
vnoremap < <gv
vnoremap > >gv
" ヴィジュアルモードで置換
vnoremap <C-r> "vy:%s/<C-r>v/<C-r>v/gc<Left><Left><Left>
" ヴィジュアルモードで*検索
vnoremap * "zy:let @/ = @z<CR>n

" help
au BufReadPost *.vim  map K :<C-u>exe ":help ".expand("<cword>")<CR>

if has("mac")
  " ;と:を入れ替える。(英字キーボード用)
  nnoremap ; :
endif

"エラーウインドウ
nnoremap <silent> <Leader>] :<C-u>cn<CR>
set grepprg=rg\ --vimgrep
" grep検索実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* copen
"nnoremap gr :<C-u>grep "<C-R><C-W>" .<CR>
"nnoremap gr :vim <cword> % \| cw<CR>
"nnoremap gR :<C-u>grep -R "<C-R><C-W>" *<CR>
" }}}

" オムニ補完 {{{
set complete+=k
set completeopt=menuone
autocmd Filetype * setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}

" グーグルサジェスト {{{
setlocal completefunc=GoogleComplete
function! GoogleComplete(findstart, base)
  if a:findstart
      let line = getline('.')
      let start = col('.') - 1
      while start > 0 && line[start - 1] =~ '\S'
          let start -= 1
      endwhile
      return start
  else
      let ret = system('curl -s -G --data-urlencode "q='
                  \ . a:base . '" "http://suggestqueries.google.com/complete/search?&client=firefox&hl=ja&ie=utf8&oe=utf8"')
      let res = split(substitute(ret,'\[\|\]\|"',"","g"),",")
      return res
  endif
endfunction
"}}}

" ターミナル{{{
tnoremap <silent> <ESC> <C-\><C-n>
"}}}

" カラースキーム{{{
"set background=dark
"colorscheme solarized8_dark
" 構文ごとに色分け表示する
syntax enable
" }}}
" vim:set ft=vim sw=2 expandtab foldmethod=marker:
