local gitsigns = require('gitsigns')
gitsigns.setup {
    current_line_blame = false,
    current_line_blame_opts = {
        delay = 250,
    }
}

if vim.g.vimrc.colorscheme == 'gruvbox' then
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GruvboxGreenSign' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GruvboxOrangeSign' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GruvboxRedSign' })
end

vim.keymap.set('n', '<leader>gl', function() gitsigns.blame_line({ full = true }) end, { silent = true })
vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame, { silent = true })
