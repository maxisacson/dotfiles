local gitsigns = require('gitsigns')

local on_attach = function(bufnr)

    vim.keymap.set('n', '<leader>gl', function() gitsigns.blame_line({ full = true }) end, { buffer = bufnr, silent = true, desc = "[GitSigns] Blame current line " })
    vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame, { buffer = bufnr, silent = true, desc = "[GitSigns] Toggle line blame" })
    vim.keymap.set('n', '<leader>gs', gitsigns.stage_hunk, { buffer = bufnr, silent = true, desc = "[GitSigns] Stage hunk under cursor" })
    vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk, { buffer = bufnr, silent = true, desc = "[GitSigns] Undo last stage hunk" })

end

gitsigns.setup {
    current_line_blame = false,
    current_line_blame_opts = {
        delay = 250,
    },
    on_attach = on_attach
}

if vim.g.vimrc.colorscheme == 'gruvbox' then
    vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GruvboxGreenSign' })
    vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GruvboxOrangeSign' })
    vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GruvboxRedSign' })
end
