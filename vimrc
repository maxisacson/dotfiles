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

" airline config
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

call SourceFile(s:currentpath . '/vimrc.ale')

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
            \ "UseTab": "Never",
            \ "SortIncludes": "false"}

" FZF config
" noremap <C-Space> :Files<CR>
noremap <C-Space> :GFiles<CR>

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
set shortmess+=c
set completeopt=noinsert,menuone,noselect
inoremap <silent> <expr> <CR> (pumvisible() ? '\<C-y>' : '\<CR>')
inoremap <silent> <expr> <Tab> (pumvisible() ? '\<C-n>' : '\<Tab>')
inoremap <silent> <expr> <S-Tab> (pumvisible() ? '\<C-p>' : '\<S-Tab>')

if has("nvim")
    " call SourceFile(s:currentpath . '/vimrc.ncm2')

    " completion-nvim config
    autocmd BufEnter * lua require'completion'.on_attach()
    imap <Tab> <Plug>(completion_smart_tab)
    imap <S-Tab> <Plug>(completion_smart_s_tab)
    let g:completion_enable_auto_popup = 0
	let g:completion_chain_complete_list = {
	    \'cpp' : [
	    \    {'complete_items': ['lsp', 'snippet', 'path']},
	    \    {'mode': '<c-p>'},
	    \    {'mode': '<c-n>'}
	    \],
	    \'default' : [
	    \    {'complete_items': ['lsp', 'snippet', 'path', 'buffers']},
	    \    {'mode': '<c-p>'},
	    \    {'mode': '<c-n>'}
	    \]
	    \}
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
