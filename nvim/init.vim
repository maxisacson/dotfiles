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
    let l:fullpath = s:currentpath . '/init.d/' . a:file
    let l:ext = strcharpart(a:file, strchars(a:file) - 3, 3)
    if l:ext == 'vim'
        call SourceFile(l:fullpath)
    elseif l:ext == 'lua'
        call LuaFile(l:fullpath)
    endif
endfunction

function! LoadConfCond(file, cond)
    if a:cond
        call LoadConf(a:file)
    endif
endfunction

call LoadConf('globals.vim')
call LoadConf('plugins.vim')
call LoadConf('common.vim')
call LoadConf('colorscheme.vim')

if has("nvim")
    call LoadConfCond('lsp.lua', g:vimrc_enable_lsp)
    call LoadConfCond('lsp_signature.lua', g:vimrc_enable_lsp)
    call LoadConfCond('ts.lua', g:vimrc_enable_treesitter)

    call LoadConf('gitsigns.lua')
endif

call LoadConfCond('nerdtree.vim', g:vimrc_enable_nerdtree)
call LoadConfCond('nvim-tree.lua', g:vimrc_enable_nvimtree)

call LoadConf('easyalign.vim')
call LoadConf('prettifymath.vim')
call LoadConf('includeguard.vim')
call LoadConf('python.vim')

call LoadConfCond('airline.vim', g:vimrc_enable_airline)
call LoadConfCond('barbar.vim', g:vimrc_enable_barbar)

if g:vimrc_enable_feline
    set noshowmode
    call LoadConf('feline.lua')
endif

call LoadConfCond('telescope.lua', g:vimrc_enable_telescope)
call LoadConfCond('fzf.vim', g:vimrc_enable_fzf)
call LoadConfCond('ack.vim', g:vimrc_enable_ack)

call LoadConf('nerdcommenter.vim')
call LoadConf('vimtex.vim')
call LoadConf('clang-format.vim')
call LoadConf('smarttab.vim')

call LoadConfCond('nvim-cmp.lua', g:vimrc_enable_nvim_cmp)

call LoadConf('colorizer.lua')
call LoadConf('whitespace.vim')
call LoadConf('autoccl.vim')
