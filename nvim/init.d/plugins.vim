call plug#begin('~/.vim/bundle')

if g:vimrc_enable_airline
    " vim-airline
    Plug 'vim-airline/vim-airline'

    " vim-airline-themes
    Plug 'vim-airline/vim-airline-themes'
endif

" extra syntax highlighting for C/C++
Plug 'justinmk/vim-syntax-extra'

" vim-fugitive for git integration
Plug 'tpope/vim-fugitive'

" ack.vim for ag and ack integration
Plug 'mileszs/ack.vim'

if g:vimrc_enable_nerdtree
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

" extra syntax for cpp-files
Plug 'maxisacson/vim-cpp-extra'

" extra syntax for tex- and bib-files
Plug 'maxisacson/vim-latex-extra'

" syntax for geant4 macro files
Plug 'maxisacson/vim-geant4-mac'

" syntax for EGS input files
Plug 'maxisacson/vim-egsinp'

if !has("nvim")
    " gruvbox theme
    Plug 'morhetz/gruvbox'
endif

" clang-format intergration for vim
Plug 'rhysd/vim-clang-format'

if g:vimrc_enable_vim_cmake
    " vim-cmake
    Plug 'vhdirk/vim-cmake'
endif

if g:vimrc_enable_fzf
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

    " LSP configurations for neovim
    Plug 'neovim/nvim-lspconfig'

    " nvim-cmp (replaces nvim-compe)
    Plug 'hrsh7th/cmp-nvim-lsp' " lsp source
    Plug 'hrsh7th/vim-vsnip'    " snippet plugin
    Plug 'hrsh7th/cmp-vsnip'    " snippet source
    Plug 'hrsh7th/cmp-buffer'   " buffer source
    Plug 'hrsh7th/cmp-path'     " path source
    Plug 'hrsh7th/nvim-cmp'

    " preconfigured snippets
    Plug 'rafamadriz/friendly-snippets'

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

    " colorscheme creation tool -- dependency for ellisonleao/gruvbox.nvim
    Plug 'rktjmp/lush.nvim'

    " gruvbox theme
    Plug 'ellisonleao/gruvbox.nvim'

    " git-blame integration
    Plug 'f-person/git-blame.nvim'

    " visualize color codes
    Plug 'norcalli/nvim-colorizer.lua'

    if g:vimrc_enable_nvimtree
        " NvimTree alternative to NerdTree
        Plug 'kyazdani42/nvim-tree.lua'
    endif

    if g:vimrc_enable_telescope
        " Telescope -- modular fuzzy finder
        Plug 'nvim-telescope/telescope.nvim'
    endif
endif

call plug#end()
