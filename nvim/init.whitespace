" vim: ft=vim
" function to remove all trailing whitespace
augroup NoTrailingWhitespace
    autocmd!
    autocmd BufWrite * call DeleteTrailingWhiteSpace()
augroup END

function! DeleteTrailingWhiteSpace()
    let cursor_pos = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor_pos)
endfunction
