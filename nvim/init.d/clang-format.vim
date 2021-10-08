" vim: ft=vim
" vim-clang-format config
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
            \ "AlignConsecutiveAssignments": "false",
            \ "AllowShortFunctionsOnASingleLine": "Inline",
            \ "BreakConstructorInitializers": "AfterColon",
            \ "IndentWidth": 4,
            \ "SpaceAfterTemplateKeyword": "false",
            \ "TabWidth": 4,
            \ "UseTab": "Never",
            \ "SortIncludes": "false"}