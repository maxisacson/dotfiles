require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
}

require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }
