if g:vimrc.fix_normalfloat_hilink_to_pmenu
    augroup FixNormalFloatPmenuHiLink
        autocmd!
        autocmd BufEnter * if g:vimrc.fix_normalfloat_hilink_to_pmenu | hi link NormalFloat Pmenu | endif
    augroup END
endif

set background=dark
if g:vimrc.colorscheme == 'gruvbox'
    let g:gruvbox_italic=1
    set termguicolors
elseif g:vimrc.colorscheme == 'solarized'
    set notermguicolors
endif
exec 'colorscheme ' . g:vimrc.colorscheme

" fix SpellBad highlight
if exists("g:colors_name")
    if g:colors_name == "solarized"
        hi SpellBad cterm=underline gui=undercurl guisp=Red
    endif
endif

" Highlight extra long lines
" highlight OverLength cterm=reverse gui=reverse
" if exists("g:colors_name") && g:colors_name == "gruvbox"
"     highlight OverLength cterm=undercurl gui=undercurl guisp=#fabd2f
" else
"     highlight OverLength cterm=underline gui=undercurl guisp=Orange
" endif
" or uncomment this for some more intricate stuff
" if exists("g:colors_name") && g:colors_name == "gruvbox"
"     let s:gruvboxcolor = 'GruvboxBg2'
"     exec 'hi OverLength cterm=undercurl gui=standout ' .
"                 \'ctermbg=' . synIDattr(hlID(s:gruvboxcolor), 'fg', 'cterm') . ' ' .
"                 \'guibg=' . synIDattr(hlID(s:gruvboxcolor), 'fg', 'gui')
" else
"     highlight OverLength ctermbg=Black
" endif
" augroup OverLengthGroup
"     autocmd!
"     autocmd BufEnter * if !exists("w:olm") | let w:olm = matchadd('OverLength', '\%>111v.\+', -1) | endif
" augroup END

" CursorLine configuration
set cursorline
if g:vimrc.colorscheme == 'solarized'
    " hi clear CursorLine " if this is on, also add:
                          " let g:ctrlp_buffer_func = {'enter': 'HighlightOn', 'exit': 'HighlightOff', }
    hi CursorLineNR ctermfg=9 ctermbg=0
endif
" " we need to restore the cursorline for NERDTree and CtrlP
" augroup NERDCursor
"     autocmd!
"     autocmd VimEnter,BufEnter NERD_tree_* hi CursorLine ctermbg=0 guibg=Gray40
"     autocmd BufLeave NERD_tree_* hi clear CursorLine
"     autocmd BufAdd * hi clear CursorLine
" augroup END

" function! HighlightOn()
"     hi CursorLine ctermbg=0 guibg=Gray40
" endfunction
"
" function! HighlightOff()
"     hi clear CursorLine
" endfunction
