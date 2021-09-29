" vim: ft=vim

call plug#begin('~/.vim/bundle')

" YouComleteMe
" Plug 'Valloric/YouCompleteMe'

" YCM-Generator
" Plug 'rdnetto/YCM-Generator'

" Ctrl-P fuzzy search
Plug 'ctrlpvim/ctrlp.vim'

" matcher for better Ctrl-P behaviour
" Plug 'burke/matcher'

" vim-poweline
" Plug 'Lokaltog/vim-powerline'

if g:vimrc_enable_airline
    " vim-airline
    Plug 'vim-airline/vim-airline'

    " vim-airline-themes
    Plug 'vim-airline/vim-airline-themes'
endif

" extra syntax highlighting for C/C++
Plug 'justinmk/vim-syntax-extra'

" Vim-solarized
Plug 'altercation/vim-colors-solarized'

" more vim themes
" Plug 'flazz/vim-colorschemes'

" vim-fugitive for git integration
Plug 'tpope/vim-fugitive'

" ag.vim for nice search features
" Plug 'rking/ag.vim' " deprecated

" ack.vim for ag and ack integration
Plug 'mileszs/ack.vim'

if g:vimrc_enable_nerdtree
    " nerdtree for file browsing
    Plug 'scrooloose/nerdtree'
endif

" python-mode
" Plug 'klen/python-mode'

" better python syntax highlighting
Plug 'hdima/python-syntax'

" nerdcomment for easy commenting
Plug 'scrooloose/nerdcommenter'

" vim-easy-align for easy alignment
Plug 'junegunn/vim-easy-align'

" vim-surround
Plug 'tpope/vim-surround'

" vim-repeat
Plug 'tpope/vim-repeat'

" markdown preview for vim
" Plug 'suan/vim-instant-markdown'

" vim-markdown
Plug 'tpope/vim-markdown'

" better syntax highlighting for javascript
Plug 'pangloss/vim-javascript'
" Plug 'jelera/vim-javascript-syntax'

" julia syntax
Plug 'JuliaEditorSupport/julia-vim'

" syntax for DAST shift reports
" Plug 'https://gitlab.cern.ch/misacson/vim-dastshiftreport.git'

" syntax for TRExFitter config files
" Plug 'https://gitlab.cern.ch/misacson/vim-trexfitter.git'

" syntastic syntax checker
" Plug 'vim-syntastic/syntastic'

" latex plugin
Plug 'lervag/vimtex'

" easymotion
Plug 'easymotion/vim-easymotion'

" vim-css-colors
" Plug 'ap/vim-css-color'

" vim-obsession for saving and restoring vim sessions
" Plug 'tpope/vim-obsession'

" extra syntax for cpp-files
Plug 'maxisacson/vim-cpp-extra'

" extra syntax for tex- and bib-files
Plug 'maxisacson/vim-latex-extra'

" syntax for geant4 macro files
Plug 'maxisacson/vim-geant4-mac'

" unimpaired keybindings
" Plug 'tpope/vim-unimpaired'

" buffergator for buffer management
Plug 'jeetsukumaran/vim-buffergator'

if !has("nvim")
    " gruvbox theme
    Plug 'morhetz/gruvbox'
endif

" clang-format intergration for vim
Plug 'rhysd/vim-clang-format'

" ALE asynchronos link engine
" Plug 'dense-analysis/ale'

" vim-cmake
Plug 'vhdirk/vim-cmake'

" fzf fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" nvim specific plugins
if has("nvim")
    " convenience functions
    Plug 'nvim-lua/plenary.nvim'

    " remote plugin manager
    " Plug 'roxma/nvim-yarp'

    " autocompletion
    " Plug 'ncm2/ncm2'
    " Plug 'ncm2/ncm2-bufword'
    " Plug 'ncm2/ncm2-path'

    " gdb integration
    " Plug 'huawenyu/neogdb.vim'

    " LSP configurations for neovim
    Plug 'neovim/nvim-lspconfig'

    " completion-nvim
    " Plug 'nvim-lua/completion-nvim'
    " Plug 'steelsojka/completion-buffers'

    " nvim-compe (replaces completion-nvim)
    " Plug 'hrsh7th/nvim-compe'

    " nvim-cmp (replaces nvim-compe)
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'

    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " better support for lsp colors
    Plug 'folke/lsp-colors.nvim'

    " devicons
    Plug 'kyazdani42/nvim-web-devicons'

    " gitsigns
    Plug 'lewis6991/gitsigns.nvim'

    if g:vimrc_enable_feline
        " feline airline alternative
        Plug 'Famiu/feline.nvim'
    endif

    if g:vimrc_enable_barbar
        " tabline plugin
        Plug 'romgrk/barbar.nvim'
    endif

    " live parameter hints
    Plug 'ray-x/lsp_signature.nvim'

    " colorscheme creation tool
    Plug 'rktjmp/lush.nvim'

    " gruvbox theme
    Plug 'npxbr/gruvbox.nvim'
    " Plug 'morhetz/gruvbox'

    " git-blame integration
    Plug 'f-person/git-blame.nvim'

    " visualize color codes
    Plug 'norcalli/nvim-colorizer.lua'

    if g:vimrc_enable_nvimtree
        " NvimTree alternative to NerdTree
        Plug 'kyazdani42/nvim-tree.lua'
    endif
endif

call plug#end()
