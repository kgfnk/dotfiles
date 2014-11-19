" [vim] _gvimrc version 7.3
"---------------------------------------------------------------------------
" カラー設定:
"---------------------------------------------------------------------------
let g:solarized_underline=1		"default value is 1
let g:solarized_contrast="normal"	"default value is normal
let g:solarized_termtrans=0
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_italic=0
let g:solarized_termcolors=16
let g:solarized_visibility="normal"
let g:solarized_diffmode="normal"
let g:solarized_hitrail=0
let g:solarized_menu=0
syntax enable
set background=dark
call togglebg#map("<F5>")
colorscheme solarized
"colorscheme darkblue
"colorscheme desert
highlight SpecialKey guifg=dimgray
highlight NonText guifg=dimgray

" 半透明化
"if has('win32')
"	gui
"	autocmd GUIEnter * set transparency=255
"	autocmd FocusGained * set transparency=255
"	autocmd FocusLost * set transparency=210
"endif

"set guifont=Migu_2M:h11:b:cANSI
set guifont=Menlo\ Regular:h14
