" Get the path to the current vimrc-file
" (1) Expand path to current script
" (2) Resolve symbolic links
" (3) Get the directory
"                        (3)      (2)     (1)
let s:currentpath = fnamemodify(resolve(expand('<sfile>:p')), ':h')
echom 'Reading config from ' . s:currentpath . '/' . expand('<sfile>:t')

set nocompatible

function! SourceFile(file)
    exec 'source ' . s:currentpath . '/' . a:file
endfunction

function! LuaFile(file)
    exec 'luafile ' . s:currentpath . '/' . a:file
endfunction

call SourceFile('init.globals')
call SourceFile('init.plugins')
call SourceFile('init.common')
call SourceFile('init.colorscheme')
call SourceFile('init.termdebug')
if has("nvim")
    call LuaFile('init.lsp')
    call LuaFile('init.ts')
endif

" Buffergator config
let g:buffergator_suppress_keymaps = 1
nnoremap <leader>bb :BuffergatorToggle<CR>
nnoremap gb :BuffergatorMruCyclePrev<CR>
nnoremap gB :BuffergatorMruCycleNext<CR>
nnoremap <leader>bt :BuffergatorTabsToggle<CR>

if g:vimrc_enable_nerdtree
    " Bind nerdtree to <leader>n
    nnoremap <leader>nt :NERDTreeToggle<CR>
endif

if g:vimrc_enable_nvimtree
    call SourceFile('init.nvimtree')
endif

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
    let guard = substitute(toupper(expand("%:t")), "\\.", "_", "g") . "_"

    let cursor_pos = getpos(".")

    execute "normal! ggO#ifndef " . guard
    execute "normal! o#define " . guard
    normal! o
    execute "normal! Go#endif /* " . guard . " */"
    normal! O
    call setpos(".", cursor_pos)
    normal! 3j
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

" airline config
if g:vimrc_enable_airline
    call SourceFile('init.airline')
endif

if g:vimrc_enable_barbar
    call SourceFile('init.barbar')
endif

if g:vimrc_enable_feline
    set noshowmode
    call LuaFile('init.feline')
endif

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

" call SourceFile('init.ale')

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
            \ "AlignConsecutiveAssignments": "false",
            \ "AllowShortFunctionsOnASingleLine": "Inline",
            \ "BreakConstructorInitializers": "AfterColon",
            \ "IndentWidth": 4,
            \ "SpaceAfterTemplateKeyword": "false",
            \ "TabWidth": 4,
            \ "UseTab": "Never",
            \ "SortIncludes": "false"}

" FZF config
call SourceFile('init.fzf')

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

" autocomplete settings
call SourceFile('init.autocomplete')

" nvim-colorizer
lua require'colorizer'.setup()

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

augroup AutoClearCursorline
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
