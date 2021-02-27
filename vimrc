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

call SourceFile(s:currentpath . '/vimrc.plugins')
call SourceFile(s:currentpath . '/vimrc.common')
call SourceFile(s:currentpath . '/vimrc.colorscheme')
call SourceFile(s:currentpath . '/vimrc.termdebug')
if has("nvim")
    call LuaFile(s:currentpath . '/vimrc.lsp')
endif

" Buffergator config
let g:buffergator_suppress_keymaps = 1
nnoremap <leader>bb :BuffergatorToggle<CR>
nnoremap gb :BuffergatorMruCyclePrev<CR>
nnoremap gB :BuffergatorMruCycleNext<CR>
nnoremap <leader>bt :BuffergatorTabsToggle<CR>

" Bind nerdtree to <leader>n
nnoremap <leader>nt :NERDTreeToggle<CR>

" Open file under cursor in new tab
" nnoremap <F3> <c-w>gf

" make <filename-no-ext>
" nnoremap <Leader>b :!make %:r<CR>

" Read .vimrc from working directory
" set exrc
" set secure

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

call SourceFile(s:currentpath . '/vimrc.airline')

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
            \ '-hicpp-no-array-decay',
            \ '-readability-uppercase-literal-suffix',
            \ '-modernize-use-trailing-return-type']
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

" FZF config
noremap <C-Space> :Files<CR>

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
