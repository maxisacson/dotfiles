" Get the path to the current vimrc-file
" (1) Expand path to current script
" (2) Resolve symbolic links
" (3) Get the directory
"                        (3)      (2)     (1)
let s:currentpath = fnamemodify(resolve(expand('<sfile>:p')), ':h')
echom 'Reading config from ' . s:currentpath . '/' . expand('<sfile>:t')

set nocompatible

function! SourceFile(file)
    exec 'source ' . a:file
endfunction

function! LuaFile(file)
    exec 'luafile ' . a:file
endfunction

function! LoadConf(file)
    let fullpath = s:currentpath . '/init.d/' . a:file
    let ext = strcharpart(a:file, strchars(a:file) - 3, 3)
    if ext == 'vim'
        call SourceFile(fullpath)
    elseif ext == 'lua'
        call LuaFile(fullpath)
    endif
endfunction

call LoadConf('globals.vim')
call LoadConf('plugins.vim')
call LoadConf('common.vim')
call LoadConf('colorscheme.vim')
call LoadConf('termdebug.vim')

if has("nvim")
    call LoadConf('lsp.lua')
    call LoadConf('lsp_signature.lua')
    call LoadConf('ts.lua')
    call LoadConf('gitsigns.lua')
endif

call LoadConf('buffergator.vim')

if g:vimrc_enable_nerdtree
    call LoadConf('nerdtree.vim')
endif

if g:vimrc_enable_nvimtree
    call LoadConf('nvimtree.vim')
endif

call LoadConf('easyalign.vim')
call LoadConf('prettifymath.vim')
call LoadConf('includeguard.vim')
call LoadConf('python.vim')

if g:vimrc_enable_airline
    call LoadConf('airline.vim')
endif

if g:vimrc_enable_barbar
    call LoadConf('barbar.vim')
endif

if g:vimrc_enable_feline
    set noshowmode
    call LoadConf('feline.lua')
endif

call LoadConf('nerdcommenter.vim')
call LoadConf('easymotion.vim')
call LoadConf('vimtex.vim')
call LoadConf('clang-format.vim')
call LoadConf('fzf.vim')
call LoadConf('ctrlp.vim')
call LoadConf('ack.vim')
call LoadConf('ag.vim')
call LoadConf('smarttab.vim')
call LoadConf('instant-markdown.vim')
call LoadConf('nvim-cmp.lua')
call LoadConf('colorizer.lua')
call LoadConf('whitespace.vim')
call LoadConf('autoccl.vim')
