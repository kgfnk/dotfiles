SpeedDatingFormat %H:%M
SpeedDatingFormat %Y/%m/%d
SpeedDatingFormat %Y年%m月%d日
let s:japanese_number = '０１２３４５６７８９'
function! s:japanized_number(string,offset,increment)
    let n = tr(a:string, s:japanese_number, '0123456789') + a:increment
    let g:hoge = a:string
    return [tr(n, '0123456789', s:japanese_number), -1]
endfunction
function! s:function(name)
    return function(substitute(a:name,'^s:',matchstr(expand('<sfile>'), '<SNR>\d\+_'),''))
endfunction
let g:speeddating_handlers += [{'regexp': '-\=\<[１２３４５６７８９０]\+\>', 'increment': s:function('s:japanized_number')}]
