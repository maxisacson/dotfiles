" Custom commands, autocommands, mappings, and functions not fitting anywhere else


" Remove all trailing whitespace on write
function! DeleteTrailingWhiteSpace()
    let cursor_pos = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor_pos)
endfunction
augroup NoTrailingWhitespace
    autocmd!
    autocmd BufWrite * call DeleteTrailingWhiteSpace()
augroup END


" Use tab and shift-tab to move in quickfix and location lists
function! SmartTab(shifttab)
    let isquickfix = !empty(filter(getwininfo(), "v:val.quickfix && !v:val.loclist"))
    let isloclist = !empty(filter(getwininfo(), "v:val.loclist"))
    if isquickfix
        return a:shifttab ? ":cprev\<CR>" : ":cnext\<CR>"
    elseif isloclist
        return a:shifttab ? ":lprev\<CR>" : ":lnext\<CR>"
    else
        return a:shifttab ? "\<S-Tab>" : "\<Tab>"
    endif
endfunction
nnoremap <silent> <expr> <Tab> SmartTab(0)
nnoremap <silent> <expr> <S-Tab> SmartTab(1)


" Auto set cursor line on winenter/winleave. This fixed some issue I can't
" remember right now
augroup AutoClearCursorline
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END


" Function to insert include guards in cpp headers
function! InsertCppIncludeGuard()
    let guard = substitute(toupper(expand("%:t")), "\\.", "_", "g") . "_"

    let cursor_pos = getpos(".")

    execute "normal! ggO#ifndef " . guard
    execute "normal! o#define " . guard
    normal! o
    execute "normal! Go#endif /* " . guard . " */"
    normal! O
    call setpos(".", cursor_pos)
    normal! 3j
endfunction
command! CppGuard call InsertCppIncludeGuard()


" Function to format math expressions inline
function! PrettifyMath()
    " remove whitespace around *, /, and ^
    s/\s*\(\*\|\/\|\^\|(\|)\)\s*/\1/ge

    " padd +, - and = with whitespace
    s/\(+\|-\|=\)/ \1 /ge

    " remove unnecessary trailing 0's
    s/0\+$/0/ge

    " remove unnecessary whitespace
    s/\s\+/ /ge
    s/^\s\+//ge
    s/\(\d\+\)\s\+\(\d\+\)\+/\1\2/ge

    " make sure negative numbers are written correctly
    s/\(^\|=\s\)-\s/\1-/ge
endfunction
" Evaluate current line using bc and make it pretty
nnoremap <Leader>= :s/=.*$//ge<CR>yypkA=<Esc>j:.!bc -l<CR>kJ:call PrettifyMath()<CR>
" Evaluate current selection using bc and make it pretty
vnoremap <Leader>= y'>p:'[,']s/^.*=//ge<CR>:'[,']-1s/\n/+/ge<CR>:s/+$//ge<CR>:.!bc -l<CR>I= <Esc>:'<,'>call PrettifyMath()<CR>j


" Reload vimrc
command! ReloadVimrc :so $MYVIMRC | echom "Reloaded " . $MYVIMRC | redraw
