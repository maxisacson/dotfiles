" vim: ft=vim
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

" use tab and shift-tab to move in quickfix and location lists
nnoremap <silent> <expr> <Tab> SmartTab(0)
nnoremap <silent> <expr> <S-Tab> SmartTab(1)
