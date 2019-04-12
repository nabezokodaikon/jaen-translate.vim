"=============================================================================
" FILE: translate.vim
" AUTHOR:  nabezokodaikon <nabezoko.daikon@gmail.com>
" License: MIT license
"=============================================================================

if exists('g:loaded_jaen_translate')
  finish
endif
let g:loaded_jaen_translate = 1

command! -nargs=0 JaEnTranslate call jaen#translate()
