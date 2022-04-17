
vim.cmd([[
    augroup PackerUserConfig
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

return require('packer').startup(function(use)
    local vimrc = vim.g.vimrc

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- vim-fugitive for git integration
    use 'tpope/vim-fugitive'

    -- ack.vim for ag and ack integration
    use {'mileszs/ack.vim', disable = not vimrc.enable_ack }

    -- nerdcomment for easy commenting
    use 'scrooloose/nerdcommenter'

    -- vim-easy-align for easy alignment
    use 'junegunn/vim-easy-align'

    -- vim-surround
    use 'tpope/vim-surround'

    -- vim-repeat
    use 'tpope/vim-repeat'

    -- vim-markdown
    use 'tpope/vim-markdown'

    -- GLSL syntax
    use 'tikhomirov/vim-glsl'

    -- latex plugin
    use 'lervag/vimtex'

    -- for diffing blocks of text
    use 'AndrewRadev/linediff.vim'

    -- extra syntax for cpp-files
    use 'maxisacson/vim-cpp-extra'

    -- extra syntax for tex- and bib-files
    use 'maxisacson/vim-latex-extra'

    -- syntax for geant4 macro files
    use 'maxisacson/vim-geant4-mac'

    -- syntax for EGS input files
    use 'maxisacson/vim-egsinp'

    -- syntax for experimental files
    use 'git@github.com:maxisacson/vim-rs-experimental-syntax.git'

    -- clang-format intergration for vim
    use 'rhysd/vim-clang-format'

    -- vim-cmake
    use { 'vhdirk/vim-cmake', disable = not vimrc.enable_vim_cmake }

    -- fzf fuzzy finder
    use { 'junegunn/fzf.vim', disable = not vimrc.enable_fzf, requires = {{'junegunn/fzf', run = vim.fn['fzf#install']}} }

    -- LSP configurations for neovim
    use { 'neovim/nvim-lspconfig', disable = not vimrc.enable_lsp }

    -- better support for lsp colors
    use { 'folke/lsp-colors.nvim', disable = not vimrc.enable_lsp }

    -- live parameter hints
    use { 'ray-x/lsp_signature.nvim', disable = not vimrc.enable_lsp or not vimrc.enable_lsp_signature }

    -- nvim-cmp for autocompletion
    use { 'hrsh7th/cmp-nvim-lsp', disable = not vimrc.enable_nvim_cmp or not vimrc.enable_lsp } -- lsp source
    use { 'hrsh7th/vim-vsnip',    disable = not vimrc.enable_nvim_cmp }  -- snippet plugin
    use { 'hrsh7th/cmp-vsnip',    disable = not vimrc.enable_nvim_cmp }  -- snippet source
    use { 'hrsh7th/cmp-buffer',   disable = not vimrc.enable_nvim_cmp }  -- buffer source
    use { 'hrsh7th/cmp-path',     disable = not vimrc.enable_nvim_cmp }  -- path source
    use { 'hrsh7th/nvim-cmp',     disable = not vimrc.enable_nvim_cmp }

    -- VSCode-like icons in completion menu
    use { 'onsails/lspkind-nvim', disable = not vimrc.enable_nvim_cmp }

    -- preconfigured snippets
    use { 'rafamadriz/friendly-snippets', disable = not vimrc.enable_nvim_cmp }

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', disable = not vimrc.enable_treesitter }

    -- feline airline alternative
    use { 'feline-nvim/feline.nvim', requires = {{'kyazdani42/nvim-web-devicons'}, {'lewis6991/gitsigns.nvim'}} }

    -- tabline plugin
    use { 'romgrk/barbar.nvim', requires = 'kyazdani42/nvim-web-devicons' }

    -- gruvbox theme
    use { 'ellisonleao/gruvbox.nvim', requires = 'rktjmp/lush.nvim' }

    -- visualize color codes
    use 'norcalli/nvim-colorizer.lua'

    -- NvimTree alternative to NerdTree
    use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }

    -- Telescope -- modular fuzzy finder
    use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim', disable = not vimrc.enable_telescope }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', disable = not vimrc.enable_telescope }

    -- Neorg note taking plugin
    use { 'nvim-neorg/neorg', requires = 'nvim-lua/plenary.nvim', disable = not vimrc.enable_neorg }

    -- orgmode for nvim
    use { 'nvim-orgmode/orgmode', disable = not vimrc.enable_orgmode }

    -- To enable more features from rust-analyzer
    use { 'simrat39/rust-tools.nvim', requires = 'nvim-lua/popup.nvim' }
end)
