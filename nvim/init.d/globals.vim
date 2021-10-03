let g:vimrc_has_nvim = has('nvim')
let g:vimrc_enable_airline = !g:vimrc_has_nvim
let g:vimrc_enable_feline = g:vimrc_has_nvim
let g:vimrc_enable_barbar = g:vimrc_has_nvim
let g:vimrc_colorscheme = 'gruvbox'

" Fix lsp floating diagnostic for 'npxbr/gruvbox.nvim'
let g:vimrc_fix_normalfloat_hilink_to_pmenu = 1

let g:vimrc_enable_nerdtree = 0
let g:vimrc_enable_nvimtree = 1
