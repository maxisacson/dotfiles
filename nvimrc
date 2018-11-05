so ~/.vimrc

" Disable guicursor
set guicursor=

" vimtex neovim support
let g:vimtex_compiler_progname = 'nvr'

" fix IncSearch colors for the solarized theme
if g:colors_name == "solarized"
    hi IncSearch cterm=reverse
endif
