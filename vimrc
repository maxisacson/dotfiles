set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" YouComleteMe
Plugin 'Valloric/YouCompleteMe'

" Ctrl-P fuzzy search
Plugin 'kien/ctrlp.vim'

" matcher for better Ctrl-P behaviour
Plugin 'burke/matcher'

" vim-poweline
" Plugin 'Lokaltog/vim-powerline'

" vim-airline
Plugin 'bling/vim-airline'

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

" Tab management
nnoremap <S-q> :tabp<CR>
nnoremap <S-w> :tabnew<CR>
nnoremap <S-e> :tabn<CR>

" Bind nerdtree to F5
nnoremap <F5> :NERDTreeToggle<CR>

" Split screen bindings
nnoremap <C-Left> <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up> <C-w>k
nnoremap <C-Down> <C-w>j

" Open file  under cursor in new tab
nnoremap <F3> <c-w>gf

" Color scheme
set background=dark
colorscheme solarized

" Read .vimrc from working directory
set exrc
set secure

" Highlight column
set colorcolumn=110
highlight ColorColumn ctermbg=Black

" include ROOT and boost in search path
let &path.=$ROOTSYS."/include".",".$BOOSTINCDIR

" Semantic completion for YCM
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" Autoclose preview window after YCM insertion
let g:ycm_autoclose_preview_window_after_insertion = 1

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
