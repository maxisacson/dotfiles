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
" Plugin 'kien/ctrlp.vim'
Plugin 'ctrlpvim/ctrlp.vim'

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
" Plugin 'altercation/vim-colors-solarized'

" more vim themes
Plugin 'flazz/vim-colorschemes'

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

" latex plugin
Plugin 'lervag/vimtex'

" easymotion
Plugin 'easymotion/vim-easymotion'

" vim-css-colors
" Plugin 'ap/vim-css-color'

" vim-obsession for saving and restoring vim sessions
Plugin 'tpope/vim-obsession'

" extra syntax for cpp-files
Plugin 'maxisacson/vim-cpp-extra'

" extra syntax for tex- and bib-files
Plugin 'maxisacson/vim-latex-extra'

" syntax for geant4 macro files
Plugin 'maxisacson/vim-geant4-mac'

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

" Set incremental search
set incsearch

" Always keep 1 line above and below cursor,
" and 5 columns to the right and left
set scrolloff=1
set sidescrolloff=5

" Line numbering
set number

" Show command
set showcmd

" Disable showmode since we're using airline
set noshowmode

" Always use ft=tex as default for .tex-files
let g:tex_flavor = 'latex'

" Map , to <Leader>
let mapleader=','

" Tab management
nnoremap <S-q> :tabp<CR>
nnoremap <S-w> :tabnew<CR>
nnoremap <S-e> :tabn<CR>
nnoremap <silent> <Leader><S-q> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <Leader><S-e> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

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

" Open file under cursor in new tab
nnoremap <F3> <c-w>gf

" make <filename-no-ext>
nnoremap <Leader>b :!make %:r<CR>

" Color scheme
set background=dark
colorscheme solarized

" Read .vimrc from working directory
" set exrc
" set secure

" Highlight column
set colorcolumn=81
highlight ColorColumn ctermbg=Black
highlight OverLength ctermbg=Black
" autocmd BufEnter * match OverLength /\%111v.\+/
autocmd BufEnter * call matchadd('OverLength', '\%>111v.\+', -1)

" vim-easy-align key bindings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

function! PrettifyMath()
    " remove whitespace around *, /, and ^
    s/\s*\(\*\|\/\|\^\|(\|)\)\s*/\1/ge

    " padd +, - and = with whitespace
    s/\(+\|-\|=\)/ \1 /ge

    " remove unnecessary trailing 0's
    s/0\+$/0/ge

    " remove unnecessary whitespace
    s/\s\+/ /ge
    s/^\s\+//ge
    s/\(\d\+\)\s\+\(\d\+\)\+/\1\2/ge

    " make sure negative numbers are written correctly
    s/\(^\|=\s\)-\s/\1-/ge
endfunction

" Evaluate current line using bc and make it pretty
nnoremap <Leader>= :s/=.*$//ge<CR>yypkA=<Esc>j:.!bc -l<CR>kJ:call PrettifyMath()<CR>

" Evaluate current selection using bc and make it pretty
vnoremap <Leader>= y'>p:'[,']s/^.*=//ge<CR>:'[,']-1s/\n/+/ge<CR>:s/+$//ge<CR>:.!bc -l<CR>I= <Esc>:'<,'>call PrettifyMath()<CR>j

" Function to insert include guards in cpp headers
function! InsertCppIncludeGuard()
    if !exists("b:current_syntax") || b:current_syntax != "cpp"
        return
    end

    let guard = substitute(toupper(expand("%:t")), "\\.", "_", "g") . "_"

    execute "normal! i#ifndef " . guard
    execute "normal! o#define " . guard
    execute "normal! Go#endif /* " . guard . " */"
    normal! k3o
    normal! k
endfunction
command! CppGuard call InsertCppIncludeGuard()

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

" python-syntax config
let python_highlight_all = 1
"let python_version_2 = 1

" PyMode config
let g:pymode = 0
"let g:pymode_rope_completion = 0
"let g:pymode_rope_lookup_project = 0
"let g:pymode_rope = 0

" CursorLine configuration
set cursorline
hi clear CursorLine
hi CursorLineNR ctermfg=9 ctermbg=0
" we need to restore the cursorline for NERDTree and CtrlP
augroup NERDCursor
    autocmd!
    autocmd BufEnter NERD_tree_* hi CursorLine ctermbg=0 guibg=Gray40
    autocmd BufLeave NERD_tree_* hi clear CursorLine
    autocmd BufAdd * hi clear CursorLine
augroup END

function! HighlightOn()
    hi CursorLine ctermbg=0 guibg=Gray40
endfunction

function! HighlightOff()
    hi clear CursorLine
endfunction


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
let g:syntastic_aggregate_errors = 1

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

" easymotion config
" Disable default mappings
let g:EasyMotion_do_mapping = 0

" `<Leader>s{char}{char}{label}`
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" vimtex config
let g:vimtex_compiler_latexmk = {'callback' : 0}

" bind clang-format
map <Leader>fw :py3f /home/max/.local/llvm-5.0.1/share/clang/clang-format.py<CR>

" CtrlP config
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn)$'
            \ }
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_use_caching = 0
let g:ctrlp_buffer_func = {'enter': 'HighlightOn', 'exit': 'HighlightOff', }

" vim-instant-markdown config
" disable autostart, preview enabled with :InstantMarkdownPreview
let g:instant_markdown_autostart = 0

" The Silver Searcher for CtrlP
" if executable('ag')
"     " replace grep with ag
"     set grepprg=ag\ --nogroup\ --nocolor
"
"     " use ag in CtrlP
"     let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" else
"     let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"     let g:ctrlp_prompt_mappings = {
"                 \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
"                 \ }
" endif

" matcher
" if executable('matcher')
"     let g:ctrlp_match_func = { 'match': 'GoodMatch' }
"
"     function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
"
"       " Create a cache file if not yet exists
"       let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
"       if !( filereadable(cachefile) && a:items == readfile(cachefile) )
"         call writefile(a:items, cachefile)
"       endif
"       if !filereadable(cachefile)
"         return []
"       endif
"
"       " a:mmode is currently ignored. In the future, we should probably do
"       " something about that. the matcher behaves like "full-line".
"       let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
"       if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
"         let cmd = cmd.'--no-dotfiles '
"       endif
"       let cmd = cmd.a:str
"
"       return split(system(cmd), "\n")
"
"     endfunction
" end

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
