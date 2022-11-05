
vim.opt.background = 'dark' -- dark background
vim.opt.termguicolors = true -- 24 bit RGB

-- set colorscheme from global config
vim.cmd('colorscheme ' .. vim.g.vimrc.colorscheme)

vim.cmd([[
    if g:vimrc.fix_normalfloat_hilink_to_pmenu
        augroup FixNormalFloatPmenuHiLink
            autocmd!
            autocmd BufEnter * if g:vimrc.fix_normalfloat_hilink_to_pmenu | hi link NormalFloat Pmenu | endif
        augroup END
    endif

    if g:vimrc.colorscheme == 'gruvbox'
        let g:gruvbox_italic=1
        set termguicolors
    elseif g:vimrc.colorscheme == 'solarized'
        set notermguicolors
    endif

    " fix SpellBad highlight
    if exists("g:colors_name")
        if g:colors_name == "solarized"
            hi SpellBad cterm=underline gui=undercurl guisp=Red
        endif
    endif

    " CursorLine configuration
    if g:vimrc.colorscheme == 'solarized'
        " hi clear CursorLine " if this is on, also add:
                              " let g:ctrlp_buffer_func = {'enter': 'HighlightOn', 'exit': 'HighlightOff', }
        hi CursorLineNR ctermfg=9 ctermbg=0
    endif
]])
