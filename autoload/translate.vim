"=============================================================================
" FILE: translate.vim
" AUTHOR:  nabezokodaikon <nabezoko.daikon@gmail.com>
" License: MIT license
"=============================================================================
function! s:getSelectedText()
    let mode = mode()
    let end_col = s:curswant() is s:INT.MAX ? s:INT.MAX : s:get_col_in_visual('.')
    let current_pos = [line('.'), end_col]
    let other_end_pos = [line('v'), s:get_col_in_visual('v')]
    let [begin, end] = s:sort_pos([current_pos, other_end_pos])
    if s:is_exclusive() && begin[1] !=# end[1]
        let end[1] -= 1
    endif
    if mode !=# 'V' && begin ==# end
        let lines = [s:get_pos_char(begin)]
    elseif mode ==# "\<C-v>"
        let [min_c, max_c] = s:sort_num([begin[1], end[1]])
        let lines = map(range(begin[0], end[0]), '
        \   getline(v:val)[min_c - 1 : max_c - 1]
        \ ')
    elseif mode ==# 'V'
        let lines = getline(begin[0], end[0])
    else
        if begin[0] ==# end[0]
            let lines = [getline(begin[0])[begin[1]-1 : end[1]-1]]
        else
            let lines = [getline(begin[0])[begin[1]-1 :]]
            \         + (end[0] - begin[0] < 2 ? [] : getline(begin[0]+1, end[0]-1))
            \         + [getline(end[0])[: end[1]-1]]
        endif
    endif
    return join(lines, "\n") . (mode ==# 'V' ? "\n" : '')
endfunction

let s:INT = { 'MAX': 2147483647 }

function! s:get_col_in_visual(pos) abort
    let [pos, other] = [a:pos, a:pos is# '.' ? 'v' : '.']
    let c = col(pos)
    let d = s:compare_pos(s:getcoord(pos), s:getcoord(other)) > 0
    \   ? len(s:get_pos_char([line(pos), c - (s:is_exclusive() ? 1 : 0)])) - 1
    \   : 0
    return c + d
endfunction

function! s:get_multi_col(pos) abort
    let c = col(a:pos)
    return c + len(s:get_pos_char([line(a:pos), c])) - 1
endfunction

function! s:is_visual(mode) abort
    return a:mode =~# "[vV\<C-v>]"
endfunction

function! s:is_exclusive() abort
    return &selection is# 'exclusive'
endfunction

function! s:curswant() abort
    return winsaveview().curswant
endfunction

function! s:getcoord(expr) abort
    return getpos(a:expr)[1:2]
endfunction

function! s:get_pos_char(...) abort
    let pos = get(a:, 1, '.')
    let [line, col] = type(pos) is# type('') ? s:getcoord(pos) : pos
    return matchstr(getline(line), '.', col - 1)
endfunction

function! s:get_pos_in_cword(cword, ...) abort
    return (s:is_visual(get(a:, 1, mode(1))) || s:get_pos_char() !~# '\k') ? 0
    \   : s:count_char(searchpos(a:cword, 'bcn')[1], s:get_multi_col('.'))
endfunction

function! s:count_char(from, to) abort
    let chars = getline('.')[a:from-1:a:to-1]
    return len(split(chars, '\zs')) - 1
endfunction

if v:version > 704 || v:version == 704 && has('patch341')
    function! s:sort_num(xs) abort
        return sort(a:xs, 'n')
    endfunction
else
    function! s:_sort_num_func(x, y) abort
        return a:x - a:y
    endfunction
    function! s:sort_num(xs) abort
        return sort(a:xs, 's:_sort_num_func')
    endfunction
endif

function! s:sort_pos(pos_list) abort
    return sort(a:pos_list, 's:compare_pos')
endfunction

function! s:compare_pos(x, y) abort
    return max([-1, min([1,(a:x[0] == a:y[0]) ? a:x[1] - a:y[1] : a:x[0] - a:y[0]])])
endfunction

function! translate#ja2en() abort
    let word = s:getSelectedText()
    let cmd = 'trans -b -show-original n -sl=ja -tl=en "' . word . '"'
    let ret = system(cmd)
    if len(ret) > 0
        echon ret
        let @+ = ret
        execute "normal! \<esc>"
    endif
endfunction

function! translate#en2ja() abort
    let word = s:getSelectedText()
    let cmd = 'trans -b -show-original n -sl=en -tl=ja "' . word . '"'
    let ret = system(cmd)
    if len(ret) > 0
        echon ret
        let @+ = ret
        execute "normal! \<esc>"
    endif
endfunction
