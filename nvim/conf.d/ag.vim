" vim: ft=vim
" The Silver Searcher for CtrlP and ack.vim
if executable('ag')
    " replace grep with ag
    set grepprg=ag\ --nogroup\ --nocolor

    " replace ack with ag
    let g:ackprg='ag --vimgrep'

    " use ag in CtrlP
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif
