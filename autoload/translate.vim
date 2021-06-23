"=============================================================================
" FILE: translate.vim
" AUTHOR:  nabezokodaikon <nabezoko.daikon@gmail.com>
" License: MIT license
"=============================================================================
function! s:getSelectedText()
    let tmp = @@
    silent normal = gvy
    let selected = @@
    return selected
endfunction

function! translate#ja2en() abort
    let word = s:getSelectedText()
    let cmd = 'trans -b -show-original n -sl=ja -tl=en "' . word . '"'
    let ret = system(cmd)
    if len(ret) > 0
        redi @">
        echon ret
        redi END
    endif
endfunction

function! translate#en2ja() abort
    let word = s:getSelectedText()
    let cmd = 'trans -b -show-original n -sl=en -tl=ja "' . word . '"'
    let ret = system(cmd)
    if len(ret) > 0
        redi @">
        echon ret
        redi END
    endif
endfunction
