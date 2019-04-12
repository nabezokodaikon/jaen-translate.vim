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

function! s:getSourceLang(word)
  let all = strlen(a:word)
  let eng = strlen(substitute(a:word, '[^\t -~]', '', 'g'))
  return eng * 2 < all ? 'ja' : 'en'
endfunction

function! s:getTransrateLang(sl)
  return a:sl == 'en' ? 'ja' : 'en'
endfunction

function! jaen#translate()
    let word = s:getSelectedText()
    let sl = s:getSourceLang(word)
    let tl = s:getTransrateLang(sl)
    let cmd = 'trans -b -show-original n -sl=' . sl . ' -tl=' . tl . ' "' . word . '"'
    let ret = system(cmd)

    if len(ret) > 0
        redi @">
        echon ret
        redi END
    endif
endfunction
