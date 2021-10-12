-- Configuration for telescope.nvim

vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>',  {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>',    {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>',  {noremap=true, silent=true})

vim.api.nvim_set_keymap('n', '<C-Space>', '<cmd>lua require("telescope.builtin").find_files()<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<C-\\>', '<cmd>lua require("telescope.builtin").live_grep()<CR>',  {noremap=true, silent=true})

local actions = require'telescope.actions'
require'telescope'.setup{
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            }
        }
    }
}
