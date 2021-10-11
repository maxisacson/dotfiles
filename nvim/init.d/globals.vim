if !exists("g:vimrc_globals")
    let g:vimrc_globals = {}
endif

let g:vimrc_has_nvim = has('nvim')

let g:vimrc_enable_airline = get(g:vimrc_globals, "enable_airline", !g:vimrc_has_nvim)
let g:vimrc_enable_feline = get(g:vimrc_globals, "enable_feline", !g:vimrc_enable_airline)
let g:vimrc_enable_barbar = get(g:vimrc_globals, "enable_barabr", !g:vimrc_enable_airline)
let g:vimrc_colorscheme = get(g:vimrc_globals, "colorscheme", "gruvbox")

" Fix lsp floating diagnostic for 'ellisonleao/gruvbox.nvim'
let g:vimrc_fix_normalfloat_hilink_to_pmenu = get(g:vimrc_globals, "fix_normalfloat_hilink_to_pmenu", 1)

let g:vimrc_enable_nerdtree = get(g:vimrc_globals, "enable_nerdtree", !g:vimrc_has_nvim)
let g:vimrc_enable_nvimtree = get(g:vimrc_globals, "enable_nvimtree", !g:vimrc_enable_nerdtree)
