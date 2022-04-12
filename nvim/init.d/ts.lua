
local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()
if vim.g.vimrc_enable_neorg then
    parser_configs.norg = {
        install_info = {
            url = "https://github.com/nvim-neorg/tree-sitter-norg",
            files = { "src/parser.c", "src/scanner.cc" },
            branch = "main"
        },
    }
end
if vim.g.vimrc_enable_orgmode then
    parser_configs.org = {
        install_info = {
            url = 'https://github.com/milisims/tree-sitter-org',
            revision = 'main',
            files = {'src/parser.c', 'src/scanner.cc'},
        },
        filetype = 'org',
    }
end

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
}

require'nvim-treesitter.install'.compilers = { "clang", "gcc" }
