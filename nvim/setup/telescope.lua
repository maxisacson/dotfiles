-- Configuration for telescope.nvim
local builtin = require('telescope.builtin')
local actions = require 'telescope.actions'
local telescope = require('telescope')

local telescope_project_files = function()
    local topts = {} -- define here if you want to define something
    local ok = pcall(builtin.git_files, topts)
    if not ok then builtin.find_files(topts) end
end

local opts = { silent = true }

vim.keymap.set('n', '<leader>ff', function() builtin.find_files({no_ignore=true}) end, opts)
vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)
vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)
vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)

vim.keymap.set('n', '<C-Space>', telescope_project_files, opts)
vim.keymap.set('n', '<C-\\>', builtin.live_grep, opts)

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
            }
        }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        }
    }
}

telescope.load_extension('fzf')
