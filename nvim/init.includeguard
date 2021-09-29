" vim: ft=vim

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
