" vi互換をOff
set nocompatible
set helplang=ja

set rtp+=~/.vim/,~/.vim/after

" エンコーディング {{{
" Encoding
scriptencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

if has('win32')
	set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
	set fileformats=dos,unix,mac
else
	set fileencodings=utf-8,ucs-bom,iso-2022-jp,sjis,cp932,euc-jp,cp20932
	set fileformats=unix,dos,mac
endif
" }}}

" プラグイン {{{
"ファイルタイプ関連を無効
filetype off
filetype plugin indent off

if has("vim_starting")
  set rtp+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

if !has("win32")
	NeoBundle "yuratomo/w3m.vim"
	" w3m.vim {{{
	let g:w3m#external_browser = 'chrome'
	let g:w3m#homepage = 'http://www.google.co.jp/'
	" }}}
endif

" 日本語整形スクリプト用の設定
NeoBundle "vim-scripts/format.vim"
"format.vim{{{
let format_allow_over_tw = 1	" ぶら下り可能幅
"}}}
NeoBundle "thinca/vim-quickrun"
" vim-quickrun {{{
let g:quickrun_config = {}
let g:quickrun_config._ = {
	\   "split": "vertical",
	\   "runner" : "vimproc"
	\}
let g:quickrun_config.html = {
		\   "command" : "open",
		\   "exec" : "%c %s",
		\   "outputter": "browser"
		\}

if !has('win32')
let g:quickrun_config.markdown = {
		\   "outputter" : "null",
		\   "command"   : "open",
		\   "cmdopt"    : "-a",
		\   "args"      : "Marked",
		\   "exec"      : "%c %o %a %s"
		\ }
else
	let g:quickrun_config.markdown = {
		\   "outputter" : "browser"
		\}
endif

"mac用
" }}}
NeoBundle "Markdown"
NeoBundle "tpope/vim-markdown"
NeoBundle "kannokanno/previm"
NeoBundle "thinca/vim-ref"
" vim-ref {{{
autocmd FileType ruby,eruby nnoremap <silent> K :<C-u>Ref refe <cword><CR>
"}}}
NeoBundle "vim-ruby/vim-ruby"
NeoBundle "tpope/vim-rails"
" 日付のインクリメント
" vim-speeddating {{{
NeoBundle "tpope/vim-speeddating"
"}}}
NeoBundle "tpope/vim-surround"
" vim-surround {{{
nmap <Leader>s ysiw		"文字で囲む
nmap <Leader>st ysst	"タグで囲む(インライン)
nmap <Leader>sT ySSt	"タグで囲む(ブロック)
" }}}
NeoBundle "mattn/emmet-vim"
" emmet-vim {{{
let g:use_emmet_complete_tag = 1
let g:user_emmet_install_global = 0
"let g:user_emmet_leader_key = '<C-,>'
autocmd FileType html,css,markdown,aspvbs EmmetInstall
let g:user_emmet_settings = {
\  'lang' : 'ja'
\}
"let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.snippets_custom.json')), "\n"))
" }}}
NeoBundle "mrtazz/simplenote.vim"
" simplenote {{{
"ID/PASSは別ファイルで定義
"let g:SimplenoteUsername = ""
"let g:SimplenotePassword = ""
source ~/.simplenoterc
let g:SimplenoteVertical=1
let g:SimplenoteFiletype="markdown"
let g:SimplenoteListHeight=30
" }}}
if !has('win32')
NeoBundle "Shougo/vimproc", {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
  \ }
endif
NeoBundleLazy 'Shougo/vimshell', {
\   'autoload' : { 'commands' : [ 'VimShellBufferDir', 'VimShell', 'VimShellPop' ] },
\   'depends': [ 'Shougo/vimproc' ],
\ }
" vimshell {{{
let s:bundle = neobundle#get('vimshell')
function! s:bundle.hooks.on_source(bundle)
	" vimshell setting
	let g:vimshell_interactive_update_time = 10
	let g:vimshell_prompt = "% "
	"let g:vimshell_secondary_prompt = "> "
	"let g:vimshell_user_prompt = 'getcwd()'
	"let g:vimshell_right_prompt = "getcwd()"
endfunction
nnoremap <silent> vs :tabnew<CR>:VimShell<CR>
nnoremap <silent> vp :VimShellPop<CR>
"}}}
NeoBundle "Shougo/neocomplete.vim"
" neocomplete {{{
"Note: This option must set it in .vimrc(.vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
" 補完を始めるキーワード長を変える
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#min_keyword_length = 2
let g:neocomplete#sources#syntax#min_keyword_length = 4

" 補完が止まった際に、スキップする長さを短くする
let g:neocomplete#skip_auto_completion_time = '1.0'

"補完するためのキーワードパターンを指定
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
"日本語を補完候補として取得しないようにする
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions',
    \ 'aspvbs' : $HOME.'/.vim/dict/aspvbs.dict',
    \ 'html' : $HOME.'/.vim/dict/html.dict'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns= {}
endif
let g:neocomplete#delimiter_patterns.vim = ['#']
let g:neocomplete#delimiter_patterns.cpp = ['::']
let g:neocomplete#delimiter_patterns.aspvbs = ['.']

" 使用する補完の種類を減らす
" 現在のSourceの取得は `:echo keys(neocomplete#variables#get_sources())`
" デフォルト: ['file', 'tag', 'neosnippet', 'vim', 'dictionary', 'omni', 'member', 'syntax', 'include', 'buffer', 'file/include']
let g:neocomplete#sources = {
  \ '_' : ['file', 'tag', 'neosnippet', 'vim', 'dictionary', 'omni', 'member', 'include', 'buffer', 'file/include']
  \ }

" Define keyword.
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup() 
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" }}}
NeoBundle "Shougo/neosnippet"
" neosnippet {{{
let g:neosnippet#enable_snipmate_compatibility = 1
" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)
"inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"}}}
NeoBundle "Shougo/neosnippet-snippets"
"neosnippet-snippets {{{
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets, ~/.vim/snippets'
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['html'] = 'html,javascript,jquery,css'
let g:neosnippet#scope_aliases['javascript'] = 'javascript,jquery'
let g:neosnippet#scope_aliases['aspvbs'] = 'html,javascript,jquery,css'
"}}}
NeoBundleLazy 'Shougo/unite.vim' , {
\   'autoload' : { 'commands' : [ 'Unite', 'UniteWithBufferDir', 'UniteResume' ] }
\ }
" unite.vim {{{
let g:unite_source_history_yank_enable =1  "history/yankの有効化
let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
	" 入力モードで開始する
	let g:unite_enable_start_insert=1
	let g:unite_enable_split_vertically = 1 "縦分割で開く
	let g:unite_winwidth = 45 "ウインドウの横幅設定
	if has('win32')
		let g:unite_source_find_command="find.exe"
	endif
endfunction

" ESCキーを2回押すとバッファを終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

nnoremap [unite] <Nop>
"nmap <Leader>u [unite]
nmap <Space> [unite]
nnoremap <silent> [unite]e :<C-u>Unite<Space>file<CR>
"カレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
"最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"バッファ
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
" ブックマーク
nnoremap <silent> [unite]bk :<C-u>Unite<Space>bookmark<CR>
"レジスタ
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
"タブ
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
"ヒストリ/ヤンク
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"ブックマーク
nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
"outline
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
"file_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
"gista
nnoremap <silent> [unite]g :<C-u>Unite<Space>gista<CR>

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> [unite]gr :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
" カーソル位置の単語をgrep検索
nnoremap <silent> [unite]gR :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W><CR>
" grep検索結果の再呼出
nnoremap <silent> [unite]gg :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> [unite]R  :<C-u>UniteResume<CR>
" vim command 一覧
noremap :<CR> :<C-u>Unite command mapping<CR>
" 過去に使ったファイル一覧
noremap :: :<C-u>Unite file_mru -buffer-name=file_mru<CR>
nnoremap <expr>tg  ':Unite tag -buffer-name=tags -input='.expand("<cword>").'<CR>'

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
"if executable('pt')
"  let g:unite_source_grep_command = 'pt'
"  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
"  let g:unite_source_grep_recursive_opt = ''
"  let g:unite_source_grep_encoding = 'utf-8'
"endif
"}}}
NeoBundle "Shougo/neomru.vim"
NeoBundle "ujihisa/unite-colorscheme"
NeoBundle "Shougo/unite-outline"
NeoBundle 'sgur/unite-qf'
NeoBundle "fuenor/qfixgrep"
" qfixgrep {{{
let mygrepprg = 'grep'
"}}}
NeoBundle "tsukkee/unite-tag"
" unite-tag{{{
autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> g<C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\|  endif

" path にヘッダーファイルのディレクトリを追加することで
" neocomplcache が include 時に tag ファイルを作成してくれる
set path+=$LIBSTDCPP
set path+=$BOOST_LATEST_ROOT
" neocomplcache が作成した tag ファイルのパスを tags に追加する
function! s:TagsUpdate()
    " include している tag ファイルが毎回同じとは限らないので毎回初期化
    setlocal tags=
    for filename in neocomplcache#sources#include_complete#get_include_files(bufnr('%'))
        execute "setlocal tags+=".neocomplcache#cache#encode_name('tags_output', filename)
    endfor
endfunction
autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> g<C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\|  endif
"}}}
NeoBundle "hallettj/jslint.vim"
NeoBundle "Shougo/vimfiler.vim"
" vimfiler {{{
" :e . でVimFilerを開く
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_enable_auto_cd = 1
"let g:vimfiler_ignore_pattern = '^\%(.git\|.DS_Store\)$'
"}}}
" DB接続
NeoBundle "vim-scripts/dbext.vim"
" dbext {{{
let g:dbext_default_history_file = '~/.dbext_history'
source ~/.dbextrc
" }}}
" URLをブラウザで開く
NeoBundle "tyru/open-browser.vim"
" open-browser {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}
NeoBundle "vim-scripts/aspvbs.vim"
NeoBundle "rking/ag.vim"
NeoBundle "thinca/vim-qfreplace"
NeoBundle "scrooloose/syntastic"
"syntastic{{{
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
"}}}
NeoBundle "altercation/vim-colors-solarized"
" vim-colors-solarized {{{
" }}}
NeoBundle "vim-scripts/DirDiff.vim"
NeoBundle "itchyny/lightline.vim"
"lightline.vim{{{
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"×":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'subseparator': { 'left': "〉", 'right': "〈" }
      \ }
"}}}
" Syntax
" html5
"NeoBundle "othree/html5.vim"
"NeoBundle "taichouchou2/html5.vim"
" javascript
NeoBundle "pangloss/vim-javascript"
NeoBundle "vim-scripts/Better-Javascript-Indentation"
" sass
NeoBundle "AtsushiM/sass-compile.vim"
NeoBundle "cakebaker/scss-syntax.vim"

"python
NeoBundle "davidhalter/jedi-vim"
NeoBundle "nathanaelkane/vim-indent-guides"
let g:indent_guides_enable_on_vim_startup = 1
" git
" fugitive{{{
NeoBundle "tpope/vim-fugitive"
"}}}

"NeoBundle "mattn/gist-vim"
""gist-vim{{{
"let g:github_user  = 'kgfnk'
"let g:gist_private = 1
"let g:gist_post_private = 1
"let g:gist_detect_filetype = 1
""}}}
NeoBundle 'lambdalisue/vim-gista', {
    \ 'depends': [
    \    'Shougo/unite.vim',
    \    'tyru/open-browser.vim',
    \]}
"vim-gista{{{
let g:gista#github_user = 'kgfnk'
let g:gista#update_on_write = 1
"windowsの場合パスの都合でエラーになるので以下を設定する。
let g:gista#directory = '~/.gista'
let g:gista#post_private = 1
"}}}
" BLog、メモ用
NeoBundle "csexton/jekyll.vim"
"jekyll.vim{{{
let g:jekyll_path = "~/webdottech"
let g:jekyll_post_suffix = "md"
map <Leader>jb  :<C-u>JekyllBuild<CR>
map <Leader>jn  :<C-u>JekyllPost<CR>
map <Leader>jl  :<C-u>JekyllList<CR>
"}}}
NeoBundle "glidenote/memolist.vim"
"memolist.vim{{{
let g:memolist_path = "~/Dropbox/Memo"
let g:memolist_memo_suffix = "md"
let g:memolist_unite        = 1
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
let g:memolist_template_dir_path = "~/.vim/template/memolist"
let g:memolist_unite_option = "-auto-preview"
"}}}
"移動、選択
NeoBundle "gcmt/wildfire.vim"
"wildfire.vim{{{
let g:wildfire_objects = ["i'", 'i"', 'i)', 'i]', 'i}', 'ip', 'it', 'i>']
"}}}
NeoBundle "mattn/webapi-vim"
"NeoBundle "vim-scripts/grep.vim"
NeoBundle "vim-scripts/taglist.vim"
"taglist.vim{{{
if has('win32')
	let Tlist_Ctags_Cmd = 'C:\bin\ctags.exe'
else
	let TList_Ctags_Cmd = "/usr/local/bin/ctags"
endif
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Open = 1
let Tlist_Enable_Fold_Column = 1	"折りたたみ
let Tlist_Auto_Update = 1		" 自動アップデート
let g:xml_syntax_folding = 1
nnoremap <silent> <F8> :TlistToggle<CR>
"}}}
NeoBundle "Lokaltog/vim-easymotion"
"vim_easymotion {{{
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_smartcase = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)
nmap s <Plug>(easymotion-s2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
"}}}
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
      \ 'depends': ['Shougo/vimproc'],
      \ 'autoload' : {
      \   'commands' : [
      \     { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
      \     { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
      \     'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
      \ ],
      \ }}
" alpaca_tags {{{
let g:alpaca_tags#config = {
       \ '_' : '-R --sort=yes --languages=+Ruby --languages=-js,JavaScript',
       \ 'js' : '--languages=+js',
       \ '-js' : '--languages=-js,JavaScript',
       \ 'vim' : '--languages=+Vim,vim',
       \ 'php' : '--languages=+php',
       \ '-vim' : '--languages=-Vim,vim',
       \ '-style': '--languages=-css,scss,js,JavaScript,html',
       \ 'scss' : '--languages=+scss --languages=-css',
       \ 'css' : '--languages=+css',
       \ 'java' : '--languages=+java $JAVA_HOME/src',
       \ 'ruby': '--languages=+Ruby',
       \ 'coffee': '--languages=+coffee',
       \ '-coffee': '--languages=-coffee',
       \ 'bundle': '--languages=+Ruby',
       \ 'asp': '--languages=+asp',
       \ }
"}}}
"NeoBundle "Shougo/neocomplcache-rsense.vim"
"let g:rsenseHome = "/usr/local/Cellar/rsense/0.3/libexec"
"let g:rsenseUseOmniFunc = 1
NeoBundle "vim-scripts/Align"
"Aplign{{{
let g:Align_xstrlen = 3
"}}}
NeoBundle "vim-scripts/SQLUtilities"
"SQLUtilities {{{
let g:sqlutil_align_where = 1
let g:sqlutil_align_comma = 1
let g:sqlutil_align_first_word = 1
let g:sqlutil_align_keyword_right = 1
let g:sqlutil_keyword_case = '\U'
"}}}
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
"NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'othree/eregex.vim'
"eregex.vim {{{
let g:eregex_default_enable = 0
let g:eregex_forward_delim = '/'
let g:eregex_backward_delim = '?'
"}}}
NeoBundle "AndrewRadev/switch.vim"
"switch.vim {{{
nnoremap - :Switch<cr>
let g:switch_custom_definitions = [
\   ['on', 'off'],
\   ['and', 'or'],
\   ['start', 'end'],
\   ['○', '×'],
\   ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine', 'ten'],
\   ['sun', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat'],
\   ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'],
\   ['日', '月', '火', '水', '木', '金', '土']
\ ]
let b:switch_custom_definitions = [
\   {
\     '\<[a-z0-9]\+_\k\+\>': {
\       '_\(.\)': '\U\1'
\     },
\     '\<[a-z0-9]\+[A-Z]\k\+\>': {
\       '\([A-Z]\)': '_\l\1'
\     },
\   },
\   {
\         '\(\k\+\)'    : '''\1''',
\       '''\(.\{-}\)''' :  '"\1"',
\        '"\(.\{-}\)"'  :   '\1',
\   },
\ ]
" foo_bar → fooBar → foo_bar
let g:variable_style_switch_definitions = [
\   {
\     '\<[a-z0-9]\+_\k\+\>': {
\       '_\(.\)': '\U\1'
\     },
\     '\<[a-z0-9]\+[A-Z]\k\+\>': {
\       '\([A-Z]\)': '_\l\1'
\     },
\   }
\ ]
nnoremap + :call switch#Switch(g:variable_style_switch_definitions)<cr>
"}}}
"ctrlp.vim{{{
NeoBundle "kien/ctrlp.vim"
"}}}
"NeoBundle "vim-scripts/YankRing.vim"
NeoBundle "LeafCage/yankround.vim"
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
nnoremap <silent><SID>(ctrlp) :<C-u>CtrlP<CR>
nmap <expr><C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : "<SID>(ctrlp)"
"gundo.vim{{{
NeoBundle "sjl/gundo.vim"
"}}}
NeoBundleLazy "vim-scripts/TaskList.vim", {
      \ "autoload": {
      \   "mappings": ['<Plug>TaskList'],
      \}}

NeoBundle "kgfnk/vim-csvtrans"

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" }}}

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
if has('mac')
	"カーソルの形を変える(iTerm2用)
	let &t_SI = "\e]50;CursorShape=1\x7"
	let &t_EI = "\e]50;CursorShape=0\x7"
endif
if has('mac')
	" ノーマルモードに戻った時に日本語入力をオフにする(MAC用)
	set imdisable
else
" インサートモードから抜けると自動的にIMEをオフにする(windows用)
	set iminsert=2
endif
"バックアップファイルを作るディレクトリ
set backupdir=~/.tmp
"スワップファイルを作るディレクトリ
set directory=~/.tmp
"undoファイル
set undodir=~/.tmp
"折りたたみ設定(manual,marker,indent)
set foldmethod=manual
set foldlevel=1
set foldnestmax=2
set foldcolumn=2
"CTRL-aで8進数の計算をさせない
set nrformats-=octal
"gf用にパスに含まれる文字を除外(windows)
set isfname-=:
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

" 見栄え{{{
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
"コマンド補完
set wildmode=full
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
"閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
"カーソルラインを表示
set cursorline
"カーソルカラムを表示（縦線）
set cursorcolumn
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set list
" どの文字でタブや改行を表示するかを設定
set listchars=tab:»-,trail:_
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
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
" 文字のないところにカーソル移動できるようにする
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
"ウィンドウを最大化して起動
"au GUIEnter * simalt ~x
" ポップアップメニューのカラーを設定
hi Pmenu guibg=#666666
hi PmenuSel guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333
set t_Co=256

" tmuxのインサートモードでカーソルを変更
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Visual選択で選択されたテキストが、自動的にクリップボードレジスタ "*" にコピーされる。
"set guioptions+=a
"横スクロール
set guioptions+=b
"スクロール開始位置を変更
set scrolloff=10
" }}}

" キーマップ設定 {{{
" コマンド
nnoremap <Leader>: q:a
nnoremap <Leader>/ q/a

" ペースト
inoremap <C-v> <ESC>"*pa
cnoremap <C-v> <C-r>+
vnoremap <C-p> I<C-r>"<ESC><ESC>

" ヴィジュアルモードで置換
vnoremap <C-r> "vy:%s/<C-r>v/<C-r>v/gc<Left><Left><Left>

" バッファ切り替え
nnoremap <C-Left> :<C-u>bp<CR>
nnoremap <C-Right> :<C-u>bn<CR>
nnoremap <C-Down> :<C-u>buffers<CR>

nnoremap <Leader>f :<C-u>VimFilerBufferDir<CR>
nnoremap <Leader>v :<C-u>vsplit<CR><C-w><C-w>:ls<CR>:buffer<Space>
nnoremap <Leader>V :<C-u>Vexplore!<CR><CR>
" マーク
"nnoremap <Space>m :marks<CR>:mark<Space>
"
" タブ
" タブ切り替え
nnoremap <C-l> gt
nnoremap <C-h> gT
nnoremap <Space>t :<C-u>tabnew<CR>
nnoremap <Space>T :<C-u>tabnew<CR>:e .<CR>

" vimrc再読込編集
nnoremap <Space>s :<C-u>source ~/.vimrc<CR> :<C-u>source ~/.gvimrc<CR>
nnoremap <Space>. :<C-u>tabnew ~/.vimrc<CR>
nnoremap <Space>, :<C-u>tabnew ~/.gvimrc<CR>

" 日付入力
inoremap <C-d><C-d> <c-r>=strftime("%Y/%m/%d")<CR>
inoremap <C-d><C-j> <c-r>=strftime("%Y年%m月%d日(%a)")<CR>
inoremap <C-d><C-t> <C-R>=strftime("%H:%M:%S")<CR>
inoremap <C-d><C-n> <C-R>=strftime("%Y/%m/%d %H:%M:%S")<CR>

"
" insertモードを抜ける
inoremap <C-j> <esc>
 " 検索結果のハイライトを消す
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>

" help
au BufReadPost *.vim  map K :<C-u>exe ":help ".expand("<cword>")<CR>
au BufReadPost .vimrc map K :<C-u>exe ":help ".expand("<cword>")<CR>

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

if has('mac')
	" ;と:を入れ替える。(英字キーボード用)
	nnoremap ; :
endif

"エラーウインドウ
nnoremap <silent> <Leader>] :<C-u>cn<CR>
set grepprg=findstr\ /nS
"set grepprg=grep\ -nHrwi
"set grepprg=grep\ -nHrwi\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude-dir=*_doc\ --exclude=*.bak
set grepprg=ag\ -S
"set grepprg=pt\ /S
autocmd QuickFixCmdPost *grep* cwindow
nnoremap gr :<C-u>grep "<C-R><C-W>" .<CR>
"nnoremap gr :vim <cword> % \| cw<CR>
nnoremap gR :<C-u>grep -R "<C-R><C-W>" *<CR>

"" TODOファイル
command! Todo edit ~/Dropbox/Memo/todo.txt
" 一時ファイル
command! -nargs=1 -complete=filetype Tmp edit ~/Dropbox/Memo/tmp.<args>

"undo履歴表示
nmap U :<C-u>GundoToggle<CR>
" TODOリスト表示
nmap <Leader>T <plug>TaskList

" }}}

" オムニ補完 {{{
set complete+=k
autocmd Filetype * setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }}}

" カラースキーム{{{
" 構文ごとに色分け表示する
syntax enable
set background=dark
colorscheme solarized

" }}}
" vim:set ft=vim foldmethod=marker:
