" vim: ft=vim

" python3 host program
function! PythonInterpreter()
    if g:vimrc_override_python3_host_prog
        return g:vimrc_python3_host_prog
    endif

    if empty(glob("/usr/bin/python3"))
        return system("which python3")
    endif

    return "/usr/bin/python3"
endfunction
let g:python3_host_prog = PythonInterpreter()

" python-syntax config
let python_highlight_all = 1
"let python_version_2 = 1

" PyMode config
let g:pymode = 0
"let g:pymode_rope_completion = 0
"let g:pymode_rope_lookup_project = 0
"let g:pymode_rope = 0

