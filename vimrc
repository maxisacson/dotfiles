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
Plugin 'ctrlpvim/ctrlp.vim'

" matcher for better Ctrl-P behaviour
" Plugin 'burke/matcher'

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

" more vim themes
" Plugin 'flazz/vim-colorschemes'

" vim-fugitive for git integration
Plugin 'tpope/vim-fugitive'

" ag.vim for nice search features
" Plugin 'rking/ag.vim' " deprecated

" ack.vim for ag and ack integration
Plugin 'mileszs/ack.vim'

" nerdtree for file browsing
Plugin 'scrooloose/nerdtree'

" python-mode
" Plugin 'klen/python-mode'

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
" Plugin 'suan/vim-instant-markdown'

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
" Plugin 'vim-syntastic/syntastic'

" latex plugin
Plugin 'lervag/vimtex'

" easymotion
Plugin 'easymotion/vim-easymotion'

" vim-css-colors
" Plugin 'ap/vim-css-color'

" vim-obsession for saving and restoring vim sessions
" Plugin 'tpope/vim-obsession'

" extra syntax for cpp-files
Plugin 'maxisacson/vim-cpp-extra'

" extra syntax for tex- and bib-files
Plugin 'maxisacson/vim-latex-extra'

" syntax for geant4 macro files
Plugin 'maxisacson/vim-geant4-mac'

" unimpaired keybindings
" Plugin 'tpope/vim-unimpaired'

" buffergator for buffer management
Plugin 'jeetsukumaran/vim-buffergator'

" gruvbox theme
Plugin 'morhetz/gruvbox'

" clang-format intergration for vim
Plugin 'rhysd/vim-clang-format'

" ALE asynchronos link engine
Plugin 'dense-analysis/ale'

" vim-cmake
Plugin 'vhdirk/vim-cmake'

" nvim specific plugins
if has("nvim")
    " remote plugin manager
    Plugin 'roxma/nvim-yarp'

    " autocompletion
    Plugin 'ncm2/ncm2'
    Plugin 'ncm2/ncm2-bufword'
    Plugin 'ncm2/ncm2-path'

    " gdb integration
    " Plugin 'huawenyu/neogdb.vim'
endif

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

" common settings
so ~/git/dotfiles/vimrc.common

" Buffergator config
let g:buffergator_suppress_keymaps = 1
nnoremap <leader>b :BuffergatorToggle<CR>
nnoremap gb :BuffergatorMruCyclePrev<CR>
nnoremap gB :BuffergatorMruCycleNext<CR>
nnoremap <leader>t :BuffergatorTabsToggle<CR>

" Bind nerdtree to <leader>n
nnoremap <leader>n :NERDTreeToggle<CR>

" Open file under cursor in new tab
" nnoremap <F3> <c-w>gf

" make <filename-no-ext>
" nnoremap <Leader>b :!make %:r<CR>

" Color scheme
let s:colorscheme = 'gruvbox'
set background=dark
if s:colorscheme == 'gruvbox'
    let g:gruvbox_italic=1
    set termguicolors
elseif s:colorscheme == 'solarized'
    set notermguicolors
endif
exec 'colorscheme ' . s:colorscheme

" fix SpellBad highlight
if exists("g:colors_name")
    if g:colors_name == "solarized"
        hi SpellBad cterm=underline gui=undercurl guisp=Red
    endif
endif

" Read .vimrc from working directory
" set exrc
" set secure

" Highlight extra long lines
" highlight OverLength cterm=reverse gui=reverse
if exists("g:colors_name") && g:colors_name == "gruvbox"
    highlight OverLength cterm=undercurl gui=undercurl guisp=#fabd2f
else
    highlight OverLength cterm=underline gui=undercurl guisp=Orange
endif
" or uncomment this for some more intricate stuff
" if exists("g:colors_name") && g:colors_name == "gruvbox"
"     let s:gruvboxcolor = 'GruvboxBg2'
"     exec 'hi OverLength cterm=undercurl gui=standout ' .
"                 \'ctermbg=' . synIDattr(hlID(s:gruvboxcolor), 'fg', 'cterm') . ' ' .
"                 \'guibg=' . synIDattr(hlID(s:gruvboxcolor), 'fg', 'gui')
" else
"     highlight OverLength ctermbg=Black
" endif
augroup OverLengthGroup
    autocmd!
    autocmd BufEnter * if !exists("w:olm") | let w:olm = matchadd('OverLength', '\%>111v.\+', -1) | endif
augroup END

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

" python3 host program
function! PythonInterpreter()
    if empty(glob("/usr/bin/python3"))
        return system("which python3")
    endif

    return "/usr/bin/python3"
endfunction
let g:python3_host_program = PythonInterpreter()

" include ROOT and boost in search path
" let &path.=$ROOTSYS."/include".",".$BOOSTINCDIR

" Semantic completion for YCM
" let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" Autoclose preview window after YCM insertion
" let g:ycm_autoclose_preview_window_after_insertion = 1

" Only use arrow keys to browse YCM completion
" let g:ycm_key_list_select_completion = ['<Down>']
" let g:ycm_key_list_previous_completion = ['<Up>']

" Fancy symbols for powerline
" let g:Powerline_symbols = 'fancy'

" Disable showmode since we're using airline
set noshowmode

" vim-airline configuration
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

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
if s:colorscheme == 'solarized'
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


" nerdcommenter configuration
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" ALE configuration
let g:ale_echo_msg_format = '%code: %%s [%linter%] (%severity%)'
let g:ale_linters_explicit = 1
let g:ale_c_parse_compile_commands = 1
let g:ale_c_build_dirs_names = ['build', 'bin', 'release']
" let g:ale_linters = {'cpp': 'all'}
let g:ale_linters = {'cpp': ['clangtidy']}
" let g:ale_cpp_clangtidy_extra_options='-isystem'
" let g:ale_cpp_clangtidy_extra_options = '-extra-arg-before=-xc++'
let g:ale_cpp_clangtidy_checks = ['-*',
            \ 'clang-analyzer-*',
            \ 'modernize-*',
            \ 'readability-*',
            \ 'performance-*',
            \ 'cppcoreguidelines-*',
            \ 'bugprone-*',
            \ 'cert-*',
            \ 'hicpp-*',
            \ '-cppcoreguidelines-pro-bounds-constant-array-index',
            \ '-cppcoreguidelines-pro-bounds-array-to-pointer-decay',
            \ '-readability-braces-around-statements',
            \ '-hicpp-braces-around-statements',
            \ '-hicpp-no-array-decay']
let g:ale_pattern_options = {
            \ '\.h\(pp\)\?$': {
                \ 'ale_cpp_clangtidy_extra_options':
                    \ '-extra-arg-before=-xc++-header'}
            \ }

nmap <leader>al <Plug>(ale_lint)
nmap <leader>an <Plug>(ale_next)
nmap <leader>ap <Plug>(ale_previous)
nmap <leader>at <Plug>(ale_toggle)

" syntastic configuration
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_aggregate_errors = 1
"
" let g:syntastic_error_symbol = ">>"
" let g:syntastic_style_error_symbol = "S>"
" let g:syntastic_warning_symbol = ">?"
" let g:syntastic_style_warning_symbol = "S?"
" let g:syntastic_aggregate_errors = 1
"
" let g:syntastic_sh_checkers = ['checkbashisms', 'sh']
" let g:syntastic_cpp_checkers = ['gcc', 'clang_check', 'cppcheck']
" let g:syntastic_cpp_clang_check_args = ["-std=c++17"]
" let g:syntastic_filetype_map = { "cpp": "h" }
"
" " Disable auto-checking
" let g:syntastic_mode_map = {
"             \ "mode": "passive",
"             \ "active_filetypes": [],
"             \ "passive_filetypes": [] }
"
" " bind ,e to run the syntastic checks
" nnoremap <Leader>sc :SyntasticCheck<CR>

" easymotion config
" Disable default mappings
let g:EasyMotion_do_mapping = 0

" `<Leader>s{char}{char}{label}`
" nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" vimtex config
let g:vimtex_compiler_latexmk = {'callback' : 0}

" vim-clang-format config
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
            \ "AlignConsecutiveAssignments": "true",
            \ "AllowShortFunctionsOnASingleLine": "Inline",
            \ "BreakConstructorInitializers": "AfterColon",
            \ "IndentWidth": 4,
            \ "SpaceAfterTemplateKeyword": "false",
            \ "TabWidth": 4,
            \ "UseTab": "Never"}


" CtrlP config
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn)$'
            \ }
let g:ctrlp_working_path_mode = 'ar'
let g:ctrlp_use_caching = 0
" let g:ctrlp_buffer_func = {'enter': 'HighlightOn', 'exit': 'HighlightOff', }
let g:ctrlp_open_new_file = 'r' " open created file in current window
let g:ctrlp_extensions = ['line'] " CtrlPLine
noremap <Leader>/ :CtrlPLine<cr>

" ack.vim config
cnoreabbrev Ack Ack!
nnoremap <C-\> :Ack!<space>

" The Silver Searcher for CtrlP and ack.vim
if executable('ag')
    " replace grep with ag
    set grepprg=ag\ --nogroup\ --nocolor

    " replace ack with ag
    let g:ackprg='ag --vimgrep'

    " use ag in CtrlP
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
endif

function! SmartTab(shifttab)
    let isquickfix = !empty(filter(getwininfo(), "v:val.quickfix && !v:val.loclist"))
    let isloclist = !empty(filter(getwininfo(), "v:val.loclist"))
    if isquickfix
        return a:shifttab ? ":cprev\<CR>" : ":cnext\<CR>"
    elseif isloclist
        return a:shifttab ? ":lprev\<CR>" : ":lnext\<CR>"
    else
        return a:shifttab ? "\<S-Tab>" : "\<Tab>"
    endif
endfunction

" use tab and shift-tab to move in quickfix and location lists
nnoremap <silent> <expr> <Tab> SmartTab(0)
nnoremap <silent> <expr> <S-Tab> SmartTab(1)

" vim-instant-markdown config
" disable autostart, preview enabled with :InstantMarkdownPreview
let g:instant_markdown_autostart = 0

" if everything on the line up to the cursor is
" whitespace insert a tab, else start autocomplete
function! CleverTab()
    if has("nvim")
        if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
            return "\<Tab>"
        else
            return "\<c-r>=ncm2#manual_trigger()\<cr>"
        endif
    else
        return "\<Tab>"
    endif
endfunction

" autocomplete settings
set shortmess+=c
set completeopt=noinsert,menuone,noselect
inoremap <silent> <expr> <CR> (pumvisible() ? "\<c-y>" : "\<CR>")
inoremap <silent> <expr> <c-j> (pumvisible() ? "\<c-n>" : "\<c-j>")
inoremap <silent> <expr> <c-k> (pumvisible() ? "\<c-p>" : "\<c-k>")
inoremap <silent> <expr> <Tab> (pumvisible() ? "\<c-n>" : CleverTab())
inoremap <silent> <expr> <S-Tab> (pumvisible() ? "\<c-p>" : "\<S-Tab>")
if has("nvim")
    " ncm2 autocomplete settings
    augroup ncm2_enable
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
    augroup END
    let g:ncm2#complete_delay = 180
    let g:ncm2#auto_popup = 0

    " ncm2 for vimtex
    augroup my_cm_setup
        autocmd!
        autocmd BufEnter * call ncm2#enable_for_buffer()
        autocmd Filetype tex call ncm2#register_source({
                    \ 'name' : 'vimtex-cmds',
                    \ 'priority': 8,
                    \ 'complete_length': -1,
                    \ 'scope': ['tex'],
                    \ 'matcher': {'name': 'prefix', 'key': 'word'},
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
                    \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                    \ })
        autocmd Filetype tex call ncm2#register_source({
                    \ 'name' : 'vimtex-labels',
                    \ 'priority': 8,
                    \ 'complete_length': -1,
                    \ 'scope': ['tex'],
                    \ 'matcher': {'name': 'combine',
                    \             'matchers': [
                    \               {'name': 'substr', 'key': 'word'},
                    \               {'name': 'substr', 'key': 'menu'},
                    \             ]},
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': g:vimtex#re#ncm2#labels,
                    \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                    \ })
        autocmd Filetype tex call ncm2#register_source({
                    \ 'name' : 'vimtex-files',
                    \ 'priority': 8,
                    \ 'complete_length': -1,
                    \ 'scope': ['tex'],
                    \ 'matcher': {'name': 'combine',
                    \             'matchers': [
                    \               {'name': 'abbrfuzzy', 'key': 'word'},
                    \               {'name': 'abbrfuzzy', 'key': 'abbr'},
                    \             ]},
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': g:vimtex#re#ncm2#files,
                    \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                    \ })
        autocmd Filetype tex call ncm2#register_source({
                    \ 'name' : 'bibtex',
                    \ 'priority': 8,
                    \ 'complete_length': -1,
                    \ 'scope': ['tex'],
                    \ 'matcher': {'name': 'combine',
                    \             'matchers': [
                    \               {'name': 'prefix', 'key': 'word'},
                    \               {'name': 'abbrfuzzy', 'key': 'abbr'},
                    \               {'name': 'abbrfuzzy', 'key': 'menu'},
                    \             ]},
                    \ 'word_pattern': '\w+',
                    \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
                    \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
                    \ })
    augroup END
endif

" function to remove all trailing whitespace
augroup NoTrailingWhitespace
    autocmd!
    autocmd BufWrite * call DeleteTrailingWhiteSpace()
augroup END

function! DeleteTrailingWhiteSpace()
    let cursor_pos = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor_pos)
endfunction
