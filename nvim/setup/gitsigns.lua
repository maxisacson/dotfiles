require('gitsigns').setup {
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 250,
    }
}

if vim.g.vimrc.colorscheme == 'gruvbox' then
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { link='GruvboxGreenSign' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { link='GruvboxOrangeSign' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { link='GruvboxRedSign' })
end
