call plug#begin('~/.vim/bundle')

if g:vimrc.enable_airline
    " vim-airline
    Plug 'vim-airline/vim-airline'

    " vim-airline-themes
    Plug 'vim-airline/vim-airline-themes'
endif

" extra syntax highlighting for C/C++
Plug 'justinmk/vim-syntax-extra'

" vim-fugitive for git integration
Plug 'tpope/vim-fugitive'

if g:vimrc.enable_ack
    " ack.vim for ag and ack integration
    Plug 'mileszs/ack.vim'
endif

if g:vimrc.enable_nerdtree
    " nerdtree for file browsing
    Plug 'scrooloose/nerdtree'
endif

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

" vim-markdown
Plug 'tpope/vim-markdown'

" better syntax highlighting for javascript
Plug 'pangloss/vim-javascript'

" julia syntax
Plug 'JuliaEditorSupport/julia-vim'

" GLSL syntax
Plug 'tikhomirov/vim-glsl'

" latex plugin
Plug 'lervag/vimtex'

" for diffing blocks of text
Plug 'AndrewRadev/linediff.vim'

" extra syntax for cpp-files
Plug 'maxisacson/vim-cpp-extra'

" extra syntax for tex- and bib-files
Plug 'maxisacson/vim-latex-extra'

" syntax for geant4 macro files
Plug 'maxisacson/vim-geant4-mac'

" syntax for EGS input files
Plug 'maxisacson/vim-egsinp'

" syntax for experimental files
Plug 'git@github.com:maxisacson/vim-rs-experimental-syntax.git'

if !has("nvim")
    " gruvbox theme
    Plug 'morhetz/gruvbox'
endif

" clang-format intergration for vim
Plug 'rhysd/vim-clang-format'

if g:vimrc.enable_vim_cmake
    " vim-cmake
    Plug 'vhdirk/vim-cmake'
endif

if g:vimrc.enable_fzf
    " fzf fuzzy finder
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
endif

" nvim specific plugins
if has("nvim")
    " convenience functions
    " dependancy for
    "   - lewis6991/gitsigns.nvim
    "   - nvim-telescope/telescope.nvim
    "   - maybe more
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'

    if g:vimrc.enable_lsp
        " LSP configurations for neovim
        Plug 'neovim/nvim-lspconfig'

        " better support for lsp colors
        Plug 'folke/lsp-colors.nvim'

        " live parameter hints
        if g:vimrc.enable_lsp_signature
            Plug 'ray-x/lsp_signature.nvim'
        endif
    endif

    if g:vimrc.enable_nvim_cmp
        " nvim-cmp (replaces nvim-compe)
        if g:vimrc.enable_lsp
            Plug 'hrsh7th/cmp-nvim-lsp' " lsp source
        endif
        Plug 'hrsh7th/vim-vsnip'    " snippet plugin
        Plug 'hrsh7th/cmp-vsnip'    " snippet source
        Plug 'hrsh7th/cmp-buffer'   " buffer source
        Plug 'hrsh7th/cmp-path'     " path source
        Plug 'hrsh7th/nvim-cmp'

        " VSCode-like icons in completion menu
        Plug 'onsails/lspkind-nvim'
    endif

    if g:vimrc.enable_nvim_cmp
        " preconfigured snippets
        Plug 'rafamadriz/friendly-snippets'
    endif

    if g:vimrc.enable_treesitter
        " treesitter
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    endif

    " devicons
    Plug 'kyazdani42/nvim-web-devicons'

    " gitsigns
    Plug 'lewis6991/gitsigns.nvim'

    if g:vimrc.enable_feline
        " feline airline alternative
        Plug 'feline-nvim/feline.nvim'
    endif

    if g:vimrc.enable_barbar
        " tabline plugin
        Plug 'romgrk/barbar.nvim'
    endif

    " colorscheme creation tool -- dependency for ellisonleao/gruvbox.nvim
    Plug 'rktjmp/lush.nvim'

    " gruvbox theme
    Plug 'ellisonleao/gruvbox.nvim'

    " git-blame integration
    " Plug 'f-person/git-blame.nvim'

    " visualize color codes
    Plug 'norcalli/nvim-colorizer.lua'

    if g:vimrc.enable_nvimtree
        " NvimTree alternative to NerdTree
        Plug 'kyazdani42/nvim-tree.lua'
    endif

    if g:vimrc.enable_telescope
        " Telescope -- modular fuzzy finder
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    endif

    " Neorg note taking plugin
    if g:vimrc.enable_neorg
        Plug 'nvim-neorg/neorg'
    endif

    if g:vimrc.enable_orgmode
        Plug 'nvim-orgmode/orgmode'
    endif

    " To enable more features from rust-analyzer
    Plug 'simrat39/rust-tools.nvim'
endif

call plug#end()
