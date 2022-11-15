-- config for nvim-tree

require 'nvim-tree'.setup {}

vim.api.nvim_set_keymap('n', '<Leader>nt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

if vim.g.vimrc.colorscheme == 'gruvbox' then
    vim.api.nvim_set_hl(0, 'NvimTreeFolderName', { link = 'GruvboxBlueBold' })
    vim.api.nvim_set_hl(0, 'NvimTreeEmptyFolderName', { link = 'GruvboxBlueBold' })
    vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { link = 'GruvboxBlueBold' })
    vim.api.nvim_set_hl(0, 'NvimTreeGitMerge', { link = 'GruvboxYellow' })
    vim.api.nvim_set_hl(0, 'NvimTreeGitNew', { link = 'GruvboxYellow' })
    vim.api.nvim_set_hl(0, 'NvimTreeGitRenamed', { link = 'GruvboxPurple' })
    vim.api.nvim_set_hl(0, 'NvimTreeGitRootFolder', { link = 'GruvboxPurple' })
    vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { link = 'GruvboxBlue' })
    vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { link = 'GruvboxBlue' })
    vim.api.nvim_set_hl(0, 'NvimTreeSymlink', { link = 'GruvboxAquaBold' })

    vim.api.nvim_set_hl(0, 'NvimTreeExecFile', { link = 'GruvboxGreen' })
    vim.api.nvim_set_hl(0, 'NvimTreeSpecialFile', { link = 'GruvboxOrangeBold' })
    vim.api.nvim_set_hl(0, 'NvimTreeImageFile', { link = 'GruvboxPurpleBold' })
    vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { link = 'GruvboxOrange' })
    vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { link = 'GruvboxRedBold' })
    vim.api.nvim_set_hl(0, 'NvimTreeGitDeleted', { link = 'GruvboxRedBold' })
    vim.api.nvim_set_hl(0, 'NvimTreeGitStaged', { link = 'GruvboxRed' })
end
