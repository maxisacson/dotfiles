set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" YouComleteMe
" Plugin 'Valloric/YouCompleteMe'

" YCM-Generator
" Plugin 'rdnetto/YCM-Generator'

" Ctrl-P fuzzy search
Plugin 'kien/ctrlp.vim'

" matcher for better Ctrl-P behaviour
Plugin 'burke/matcher'

" vim-poweline
" Plugin 'Lokaltog/vim-powerline'

" vim-airline
Plugin 'vim-airline/vim-airline'

" vim-airline-themes
Plugin 'vim-airline/vim-airline-themes'

" extra syntax highlighting for C/C++
Plugin 'justinmk/vim-syntax-extra'

" Vim-solarized
Plugin 'altercation/vim-colors-solarized'

" vim-fugitive for git integration
Plugin 'tpope/vim-fugitive'

" ag.vim for nice search features
Plugin 'rking/ag.vim'

" nerdtree for file browsing
Plugin 'scrooloose/nerdtree'

" python-mode
Plugin 'klen/python-mode'

" better python syntax highlighting
Plugin 'hdima/python-syntax'

" nerdcomment for easy commenting
Plugin 'scrooloose/nerdcommenter'

" vim-easy-align for easy alignment
Plugin 'junegunn/vim-easy-align'

" vim-surround
Plugin 'tpope/vim-surround'

" vim-repeat
Plugin 'tpope/vim-repeat'

" markdown preview for vim
Plugin 'suan/vim-instant-markdown'

" vim-markdown
Plugin 'tpope/vim-markdown'

" better syntax highlighting for javascript
Plugin 'pangloss/vim-javascript'
" Plugin 'jelera/vim-javascript-syntax'

" julia syntax
Plugin 'JuliaEditorSupport/julia-vim'

" syntax for DAST shift reports
Plugin 'https://gitlab.cern.ch/misacson/vim-dastshiftreport.git'

" syntax for TRExFitter config files
Plugin 'https://gitlab.cern.ch/misacson/vim-trexfitter.git'

" syntastic syntax checker
Plugin 'vim-syntastic/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Pathogen
" execute pathogen#infect()
" filetype plugin indent on

" Standard config
syntax on

" Set indenting stuff
set ts=4
set shiftwidth=4
set expandtab
set smarttab
set ls=2
set backspace=2

" Line numbering
set number

" Show command
set showcmd

" Map , to <Leader>
let mapleader=','

" Tab management
nnoremap <S-q> :tabp<CR>
nnoremap <S-w> :tabnew<CR>
nnoremap <S-e> :tabn<CR>

" Bind nerdtree to F5
nnoremap <F5> :NERDTreeToggle<CR>

" Split screen movement bindings
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

" Split screen resize bindings
nnoremap <Leader>+ <C-w>+
nnoremap <Leader>- <C-w>-
nnoremap <Leader>z <C-w>>
nnoremap <Leader>< <C-w><

" Open file  under cursor in new tab
nnoremap <F3> <c-w>gf

" LaTeX compilation
nnoremap <S-Tab> :!lualatex %<CR>

" Color scheme
set background=dark
colorscheme solarized

" Read .vimrc from working directory
set exrc
set secure

" Highlight column
set colorcolumn=110
highlight ColorColumn ctermbg=Black

" vim-easy-align key bindings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" include ROOT and boost in search path
let &path.=$ROOTSYS."/include".",".$BOOSTINCDIR

" Semantic completion for YCM
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" Autoclose preview window after YCM insertion
let g:ycm_autoclose_preview_window_after_insertion = 1

" Only use arrow keys to browse YCM completion
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" Fancy symbols for powerline
" let g:Powerline_symbols = 'fancy'

" vim-airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" The Silver Searcher
" if executable('ag')
"     " replace grep with ag
"     set grepprg=ag\ --nogroup\ --nocolor
"
"     " use ag in CtrlP
"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" endif

" python-syntax config
let python_highlight_all = 1
"let python_version_2 = 1

" PyMode config
let g:pymode = 0
"let g:pymode_rope_completion = 0
"let g:pymode_rope_lookup_project = 0
"let g:pymode_rope = 0

" nerdcommenter configuration
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_error_symbol = ">>"
let g:syntastic_style_error_symbol = "S>"
let g:syntastic_warning_symbol = ">?"
let g:syntastic_style_warning_symbol = "S?"
let g:syntastic_aggregate_errors = 0

let g:syntastic_sh_checkers = ['checkbashisms', 'sh']

let g:syntastic_cpp_checkers = ['gcc', 'clang_check', 'cppcheck']

let g:syntastic_cpp_clang_check_args =
            \ ["-std=c++11"]

" Disable auto-checking
let g:syntastic_mode_map = {
            \ "mode": "passive",
            \ "active_filetypes": [],
            \ "passive_filetypes": [] }

" bind ,e to run the syntastic checks
nnoremap <Leader>e :SyntasticCheck<CR>

" matcher
if executable('matcher')
    let g:ctrlp_match_func = { 'match': 'GoodMatch' }

    function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

      " Create a cache file if not yet exists
      let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
      if !( filereadable(cachefile) && a:items == readfile(cachefile) )
        call writefile(a:items, cachefile)
      endif
      if !filereadable(cachefile)
        return []
      endif

      " a:mmode is currently ignored. In the future, we should probably do
      " something about that. the matcher behaves like "full-line".
      let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
      if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
        let cmd = cmd.'--no-dotfiles '
      endif
      let cmd = cmd.a:str

      return split(system(cmd), "\n")

    endfunction
end

" vim-macro to switch between header and source file in ATLAS software
" let g:path_separator = '/'
" so ~/.vim/altfile.vim

" function to remove all trailing whitespace
autocmd BufWrite * call DeleteTrailingWhiteSpace()
function! DeleteTrailingWhiteSpace()
    let a:cursor_pos = getpos(".")
    %s/\s\+$//ge
    call setpos(".", a:cursor_pos)
endfunction
