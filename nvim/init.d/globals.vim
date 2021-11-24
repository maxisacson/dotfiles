if !exists("g:vimrc_globals")
    let g:vimrc_globals = {}
endif

let g:vimrc_has_nvim = has('nvim')

let g:vimrc_enable_airline = get(g:vimrc_globals, "enable_airline", !g:vimrc_has_nvim)
let g:vimrc_enable_feline = get(g:vimrc_globals, "enable_feline", !g:vimrc_enable_airline)
let g:vimrc_enable_barbar = get(g:vimrc_globals, "enable_barbar", !g:vimrc_enable_airline)
let g:vimrc_colorscheme = get(g:vimrc_globals, "colorscheme", "gruvbox")

" Fix lsp floating diagnostic for 'ellisonleao/gruvbox.nvim'
let g:vimrc_fix_normalfloat_hilink_to_pmenu = get(g:vimrc_globals, "fix_normalfloat_hilink_to_pmenu", v:true)

let g:vimrc_enable_nerdtree = get(g:vimrc_globals, "enable_nerdtree", !g:vimrc_has_nvim)
let g:vimrc_enable_nvimtree = get(g:vimrc_globals, "enable_nvimtree", !g:vimrc_enable_nerdtree)

let g:vimrc_override_python3_host_prog = has_key(g:vimrc_globals, "python3_host_prog")
if g:vimrc_override_python3_host_prog
    let g:vimrc_python3_host_prog = g:vimrc_globals["python3_host_prog"]
endif

let g:vimrc_enable_vim_cmake = get(g:vimrc_globals, "enable_vim_cmake", executable("cmake"))
let g:vimrc_enable_telescope = get(g:vimrc_globals, "enable_telescope", v:false)
let g:vimrc_enable_fzf = get(g:vimrc_globals, "enable_fzf", !g:vimrc_enable_telescope)
let g:vimrc_enable_ack = get(g:vimrc_globals, "enable_ack", !g:vimrc_enable_telescope)
let g:vimrc_enable_lsp = get(g:vimrc_globals, "enable_lsp", v:true)
let g:vimrc_enable_treesitter = get(g:vimrc_globals, "enable_treesitter", v:true)
let g:vimrc_enable_nvim_cmp = get(g:vimrc_globals, "enable_nvim_cmp", v:true)
let g:vimrc_pylsp_cmd = get(g:vimrc_globals, "pylsp_cmd", "pylsp")
