" source from ~/.config/nvim/init.vim
so ~/.vimrc

" Disable guicursor
set guicursor=

" vimtex neovim support
let g:vimtex_compiler_progname = 'nvr'

" fix IncSearch colors for the solarized theme
if exists("g:colors_name") && g:colors_name == "solarized"
    hi IncSearch cterm=reverse
endif
