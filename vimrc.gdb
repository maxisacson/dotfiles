so ~/git/dotfiles/vimrc.common
let g:termdebug_wide = 1
set background=dark
packadd termdebug

map ,b :Break<CR>
map ,d :Clear<CR>
map ,c :call TermDebugSendCommand('continue')<CR>
map ,f :call TermDebugSendCommand('finish')<CR>
map ,n :call TermDebugSendCommand('next')<CR>
map ,s :call TermDebugSendCommand('step')<CR>
map <CR> :call TermDebugSendCommand('')<CR>
