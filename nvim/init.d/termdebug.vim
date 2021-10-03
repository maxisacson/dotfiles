let g:termdebug_wide = 1
packadd termdebug
if exists("g:colors_name") && g:colors_name == "gruvbox"
    " hi debugPC term=reverse ctermbg=239 guibg=#504945
    hi! link debugPC PmenuSbar
    hi! link debugBreakpoint ErrorMsg
endif

noremap <silent> <Leader>bp :Break<CR>
noremap <silent> <Leader>bc :Clear<CR>
" map <silent> <F5> :call TermDebugSendCommand('continue')<CR>
" map <silent> <F10> :call TermDebugSendCommand('next')<CR>
" map <silent> <F11> :call TermDebugSendCommand('step')<CR>
" map <silent> <F23> :call TermDebugSendCommand('finish')<CR>
" map <silent> <CR> :call TermDebugSendCommand('')<CR>
