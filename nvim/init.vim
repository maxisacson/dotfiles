" Get the path to the current vimrc-file
" (1) Expand path to current script
" (2) Resolve symbolic links
" (3) Get the directory
"                        (3)      (2)     (1)
let s:currentpath = fnamemodify(resolve(expand('<sfile>:p')), ':h')
echom 'Reading config from ' . s:currentpath . '/' . expand('<sfile>:t')

set nocompatible

function! SourceFile(file)
    exec 'source ' . s:currentpath . '/' . a:file
endfunction

function! LuaFile(file)
    exec 'luafile ' . s:currentpath . '/' . a:file
endfunction

call SourceFile('init.globals')
call SourceFile('init.plugins')
call SourceFile('init.common')
call SourceFile('init.colorscheme')
call SourceFile('init.termdebug')

if has("nvim")
    call LuaFile('init.lsp')
    call LuaFile('init.ts')
endif

call SourceFile('init.buffergator')

if g:vimrc_enable_nerdtree
    call SourceFile('init.nerdtree')
endif

if g:vimrc_enable_nvimtree
    call SourceFile('init.nvimtree')
endif

call SourceFile('init.easyalign')
call SourceFile('init.prettifymath')
call SourceFile('init.includeguard')
call SourceFile('init.python')

if g:vimrc_enable_airline
    call SourceFile('init.airline')
endif

if g:vimrc_enable_barbar
    call SourceFile('init.barbar')
endif

if g:vimrc_enable_feline
    set noshowmode
    call LuaFile('init.feline')
endif

call SourceFile('init.nerdcommenter')
" call SourceFile('init.ale')
call SourceFile('init.easymotion')
call SourceFile('init.vimtex')
call SourceFile('init.clang-format')
call SourceFile('init.fzf')
call SourceFile('init.ctrlp')
call SourceFile('init.ack')
call SourceFile('init.ag')
call SourceFile('init.smarttab')
call SourceFile('init.instant-markdown')
call SourceFile('init.autocomplete')
call LuaFile('init.colorizer')
call SourceFile('init.whitespace')
call SourceFile('init.autoccl')
