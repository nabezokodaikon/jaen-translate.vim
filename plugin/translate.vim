"=============================================================================
" FILE: translate.vim
" AUTHOR:  nabezokodaikon <nabezoko.daikon@gmail.com>
" License: MIT license
"=============================================================================

if exists('g:loaded_jaen_translate')
  finish
endif
let g:loaded_jaen_translate = 1

command! -nargs=0 TranslateJa2En call translate#ja2en()
command! -nargs=0 TranslateEn2Ja call translate#en2ja()
